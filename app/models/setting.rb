class Setting < ActiveRecord::Base
  belongs_to :org
  
  serialize :default_location_spaces, JSON
  
  attr_accessor :stripe_secret_key_unencrypted
  
  before_validation :empty_default_location_spaces
  before_validation :autofill_salt_if_blank
  
  validates :org, presence: true
  validates :salt, presence: true
  
  def empty_default_location_spaces
    if !default_location_spaces || default_location_spaces == {}
      self.default_location_spaces = { 'locations' => {} } 
    end
  end
  
  def autofill_salt_if_blank
    return true unless self.salt.blank? # Bypass if salt is already set
    self.salt = SecureRandom.hex(64).to_s
  end
end
