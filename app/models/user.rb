class User < ActiveRecord::Base
  
  validates :username, uniqueness: { case_sensitive: false, allow_nil: true }
  
  def self.create_or_update_user_from_omniauth(omniauth_auth)
    # Look up the id of the user according to the provider name
    provider_name = omniauth_auth['provider']
    existing_user = User.where("#{provider_name}id" => omniauth_auth['uid']).first
    if existing_user
      unless omniauth_auth['info']['email'].blank?
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

      values["#{provider_name}id".to_sym] = omniauth_auth['uid']
      values[:email] = omniauth_auth['info']['email'] unless omniauth_auth['info']['email'].blank?
      # Twitter gives us a nickname
      values[:username] = omniauth_auth['info']['nickname'] unless omniauth_auth['info']['nickname'].blank?
      
      existing_user = User.create(values)
    end
    
    existing_user
  end
  
  def full_name
    "#{self.first_name}#{self.middle_name.blank? ? '' : ' '+self.middle_name} #{self.last_name}"
  end
end
