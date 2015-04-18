class Location < ActiveRecord::Base
  belongs_to :org
  has_many :spaces, dependent: :destroy
  has_many :reservations, through: :spaces
  has_many :memberships, dependent: :destroy
  
  before_validation :autofill_permalink_if_blank
  
  validates :permalink, presence: true, uniqueness: { case_sensitive: false, scope: :org_id }, format: { with: /\A[a-zA-Z0-9\-_]+\Z/ }
  validates :timezone, presence: true
  validates :org, presence: true
  
  def autofill_permalink_if_blank
    return true unless self.permalink.blank? # Bypass if permalink is already set
    self.permalink = AutoPermalink::cleaned_deduped_permalink(self.class, self.name)
  end

  def to_param
    self.permalink
  end
  
  def opening_time_on(date_and_time)
    opening_value = begin
      case date_and_time.wday
      when 0
        sunday_opening
      when 1
        monday_opening
      when 2
        tuesday_opening
      when 3
        wednesday_opening
      when 4
        thursday_opening
      when 5
        friday_opening
      when 6
        saturday_opening
      else
        monday_opening
      end
    end
    hour = (opening_value / 100.00).floor
    return date_and_time.in_time_zone(self.timezone).change({ hour: (opening_value / 100.00).floor, minute: opening_value - (hour*100) })
  end
  
  def earliest_opening
    [self.sunday_opening, self.monday_opening, self.tuesday_opening, self.wednesday_opening, self.thursday_opening, self.friday_opening, self.saturday_opening].min
  end
  
  def latest_closing
    [self.sunday_closing, self.monday_closing, self.tuesday_closing, self.wednesday_closing, self.thursday_closing, self.friday_closing, self.saturday_closing].max
  end
  
  def max_hours_open
    max_difference = [
      self.sunday_closing - self.sunday_opening, 
      self.monday_closing - self.monday_opening,
      self.tuesday_closing - self.tuesday_opening,
      self.wednesday_closing - self.wednesday_opening,
      self.thursday_closing - self.thursday_opening,
      self.friday_closing - self.friday_opening,
      self.saturday_closing - self.saturday_opening
    ].max
    
    (max_difference / 100.00).floor
  end
  
end
