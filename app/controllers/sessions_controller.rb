class SessionsController < ApplicationController
  def create
    session[:current_user] = request.env['omniauth.auth']
    
    logger.debug "SESSION: #{session[:current_user].to_json}"
    
    User.create_or_update_user_from_omniauth(request.env['omniauth.auth'])
    redirect_to session[:after_auth_url] || root_url
  end
  
  def new
  end
end
