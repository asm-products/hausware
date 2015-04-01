class User < ActiveRecord::Base
  
  before_validation :autofill_username_if_blank
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9\-_]+\Z/ }

  # Only allow one account per Provider ID
  validates :angellistid,  uniqueness: { case_sensitive: false, allow_nil: true }
  validates :facebookid,   uniqueness: { case_sensitive: false, allow_nil: true }
  validates :githubid,     uniqueness: { case_sensitive: false, allow_nil: true }
  validates :googleid,     uniqueness: { case_sensitive: false, allow_nil: true }
  validates :linkedinid,   uniqueness: { case_sensitive: false, allow_nil: true }
  validates :twitterid,    uniqueness: { case_sensitive: false, allow_nil: true }

  def to_param
    self.username
  end
  
  def self.oauth_provider_to_id_attr(provider_name)
    if provider_name == 'google_oauth2'
      return "googleid"
    else
      return "#{provider_name}id"
    end
  end
  
  def self.find_from_omniauth(omniauth_auth)
    # Look up the id of the user according to the provider name
    provider_name = oauth_provider_to_id_attr(omniauth_auth['provider'])
    existing_user = User.where(provider_name => omniauth_auth['uid']).first
    
    if !existing_user && !omniauth_auth['info']['email'].blank? # Try to find with email instead of id
      existing_user = User.where(email: omniauth_auth['info']['email']).first
    end
    
    return existing_user
  end
  
  def self.create_or_update_user_from_omniauth(omniauth_auth)
    existing_user = find_from_omniauth(omniauth_auth)

    if existing_user
      unless omniauth_auth['info']['email'].blank? && omniauth_auth['info']['image'].blank?
        # Always get a new image, and perhaps an email
        new_values = { picurl: omniauth_auth['info']['image'] }
        new_values[:email] = omniauth_auth['info']['email'] unless !existing_user.email.blank? || omniauth_auth['info']['email'].blank?
        
        existing_user.update_attributes(new_values)
      end
    else
      values = {
        first_name:      omniauth_auth['info']['name'].partition(" ").first.partition(" ").first,
        middle_name:     omniauth_auth['info']['name'].partition(" ").first.partition(" ").last,
        last_name:       omniauth_auth['info']['name'].rpartition(" ").last,
        picurl:          omniauth_auth['info']['image']
      }

      values[oauth_provider_to_id_attr(omniauth_auth['provider']).to_sym] = omniauth_auth['uid']
      values[:email] = omniauth_auth['info']['email'] unless omniauth_auth['info']['email'].blank?
      # Twitter gives us a nickname
      values[:username] = AutoPermalink::cleaned_deduped_permalink(self, omniauth_auth['info']['nickname'], 'username') unless omniauth_auth['info']['nickname'].blank?
      
      existing_user = User.create(values)
    end
    
    existing_user
  end
  
  # Allow users to connect multiple omni auth
  def update_and_connect_omniauth(omniauth_auth)
    existing_id_for_provider = self.send(User.oauth_provider_to_id_attr(omniauth_auth['provider']))
    
    if existing_id_for_provider.blank?
      new_values = { picurl: omniauth_auth['info']['image'] }
      new_values[User.oauth_provider_to_id_attr(omniauth_auth['provider']).to_sym] = omniauth_auth['uid']
      new_values[:email] = omniauth_auth['info']['email'] unless !self.email.blank? || omniauth_auth['info']['email'].blank?
    
      return update_attributes(new_values)
    end
    true
  end
  
  def full_name
    "#{self.first_name}#{self.middle_name.blank? ? '' : ' '+self.middle_name} #{self.last_name}"
  end
  
  def autofill_username_if_blank
    return true unless self.username.blank? # Bypass if username is already set
    self.username = AutoPermalink::cleaned_deduped_permalink(self.class, self.full_name, 'username')
  end
end
