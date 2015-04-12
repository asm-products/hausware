class Reservation < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
  
  before_validation :autofill_confirmation_if_blank
  before_validation :adjust_times_to_inside_timezone
  before_validation :recalculate_price_in_cents
  
  validates :confirmation, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9\-_]+\Z/ }
  validates :space, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  
  attr_accessor :save_details_for_next_time, :timezone, :stripe_token
  
  before_create :charge_via_stripe
  
  after_save :save_details_for_next_time_to_user

  def to_param
    self.confirmation
  end
  
  def charge_via_stripe
    begin
      customer = Stripe::Customer.create(
        email: self.email,
        card: self.stripe_token,
        metadata: (self.user.blank? ? {} : { user_id: self.user.id })
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: self.recalculate_price_in_cents,
        description: "#{self.duration_in_hours} hour#{self.duration_in_hours == 1 ? '' : 's'} starting at #{self.starts_at_in_zone.strftime('%I:%M%p (%Z), %m/%d/%y')} - #{self.space.name}, #{self.space.location.name}",
        currency: 'usd',
        metadata: { confirmation: self.confirmation, location_permalink: self.space.location.permalink, space_permalink: self.space.permalink }
      )

      self.chargeid = "stripe-#{charge.id}"
      
      return true
    rescue Stripe::CardError => e
      flash[:error] = e.message
      return false
    end
  end
  
  def duration_in_hours
    ends_at.minus_with_coercion(starts_at) / 1.hour
  end
  
  def recalculate_price_in_cents
    self.price_in_cents = (self.duration_in_hours * self.space.standard_hourly_price_in_cents).floor
  end
  
  def hack_for_datetimeselect
    @hack_for_datetimeselect = {
      starts_at: self.starts_at,
      ends_at: self.ends_at
    }
    
    self.starts_at = ActiveSupport::TimeZone['UTC'].parse starts_at_in_zone.strftime('%F %T')
    self.ends_at = ActiveSupport::TimeZone['UTC'].parse ends_at_in_zone.strftime('%F %T')
  end
  def undo_hack_for_datetimeselect
    self.starts_at = @hack_for_datetimeselect[:starts_at]
    self.ends_at = @hack_for_datetimeselect[:ends_at]
  end
  
  # Only overwrites phone & zipcode, and imports email if not previously saved to user
  def save_details_for_next_time_to_user
    return true unless self.user # require a user to save to next time
    
    details = {}
    details[:email] = self.email if self.user.email.blank?
    details[:phone] = self.phone
    details[:zipcode] = self.zipcode
    
    self.user.update_attributes(details)
    true # Keep filter chain going even if it couldn't save details
  end
  
  # Adjust the selected start and ends to be according to the timezone
  def adjust_times_to_inside_timezone
    return if self.timezone.blank?
    
    self.starts_at = ActiveSupport::TimeZone[self.timezone.blank? ? self.space.location.timezone : self.timezone].parse "#{self.starts_at.to_s(:db)}" unless self.starts_at.blank?
    self.ends_at = ActiveSupport::TimeZone[self.timezone.blank? ? self.space.location.timezone : self.timezone].parse "#{self.ends_at.to_s(:db)}" unless self.ends_at.blank?
    
    true # keep filter chain going
  end
  
  def starts_at_in_zone
    starts_at.in_time_zone(self.timezone.blank? ? self.space.location.timezone : self.timezone)
  end
  
  def ends_at_in_zone
    ends_at.in_time_zone(self.timezone.blank? ? self.space.location.timezone : self.timezone)
  end
  
  def duration_in_hours
    ((ends_at - starts_at) / 1.hour).round
  end
  
  def autofill_confirmation_if_blank
    return true unless self.confirmation.blank? # Bypass if username is already set
    self.confirmation = AutoPermalink::cleaned_deduped_permalink(self.class, /[:word:]-[:word:]-\d{1,3}+/.gen, 'confirmation')
  end
end
