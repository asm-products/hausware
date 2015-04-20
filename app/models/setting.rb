class Setting < ActiveRecord::Base
  belongs_to :org
  
  serialize :default_location_spaces, JSON
  
  attr_accessor :stripe_secret_key_unencrypted
  
  before_validation :empty_default_location_spaces
  before_validation :autofill_salt_if_blank
  before_validation :encrypt_secret_key_if_filled
  
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
  
  def encrypt_secret_key_if_filled
    return true if self.stripe_secret_key_unencrypted.blank? # only do this if not blank
    
    crypt = ActiveSupport::MessageEncryptor.new(self.salt)
    self.stripe_secret_key_encrypted = crypt.encrypt_and_sign(self.stripe_secret_key_unencrypted)
  end
  
  def decrypted_stripe_secret_key
    crypt = ActiveSupport::MessageEncryptor.new(self.salt)
    crypt.decrypt_and_verify(self.stripe_secret_key_encrypted)
  end
end
