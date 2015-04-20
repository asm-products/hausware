class Setting < ActiveRecord::Base
  belongs_to :org
  
  serialize :default_location_spaces, JSON
  
  attr_accessor :stripe_secret_key_unencrypted
  
  before_validation :empty_default_location_spaces
  
  validates :org, presence: true
  validates :salt, presence: true
  
  def empty_default_location_spaces
    if !default_location_spaces || default_location_spaces == {}
      self.default_location_spaces = { 'locations' => {} } 
    end
  end
end
