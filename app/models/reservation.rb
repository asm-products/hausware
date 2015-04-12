class Reservation < ActiveRecord::Base
  belongs_to :space
  belongs_to :user
  
  before_validation :adjust_times_to_inside_timezone
  
  validates :space, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  
  attr_accessor :save_details_for_next_time, :timezone
  
  after_save :save_details_for_next_time_to_user
  
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
    
    self.starts_at = ActiveSupport::TimeZone[self.timezone].parse "#{self.starts_at.to_s(:db)} UTC" unless self.starts_at.blank?
    self.ends_at = ActiveSupport::TimeZone[self.timezone].parse "#{self.ends_at.to_s(:db)} UTC" unless self.ends_at.blank?
    
    true # keep filter chain going
  end
  
  def starts_at_in_zone
    starts_at.in_time_zone(self.timezone)
  end
  
  def ends_at_in_zone
    ends_at.in_time_zone(self.timezone)
  end
  
  def duration_in_hours
    ((ends_at - starts_at) / 1.hour).round
  end
end
