class Membership < ActiveRecord::Base
  PRIVILEGE_CODES = { administration: 'administration', reception: 'reception' }
  VALID_PRIVILEGES = PRIVILEGE_CODES.values
  
  belongs_to :org
  belongs_to :location
  belongs_to :user
  
  attr_accessor :user_via_email # Allow membership to be added by email.
  
  validates :org_id, uniqueness: { scope: :user_id }
  validates :location_id, uniqueness: { scope: :user_id }
  validates :user, presence: { message: '- no user account found with that email.  Please have your friend login for free, first!' }
  validates :privileges, presence: true, inclusion: { in: VALID_PRIVILEGES, message: "%{value} setting is not valid." }
  
  before_validation :set_user_via_email
  
  
  def set_user_via_email
    return true unless self.user.nil?
    self.user = User.find_by_email(self.user_via_email)
  end
  
  # Can read only in this org, and not do anything.
  def reception?
    self.privileges == PRIVILEGE_CODES[:reception] || self.administration?
  end
  
  # Can admin everything in this org
  def administration?
    self.privileges == PRIVILEGE_CODES[:administration]
  end
end
