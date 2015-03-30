Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user:email'
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'], scope: 'r_emailaddress r_contactinfo r_fullprofile'
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: 'email'
  provider :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET'] 
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], { access_type: 'online' }
  provider :identity, fields: [ :email ]
end

OmniAuth.config.logger = Rails.logger
