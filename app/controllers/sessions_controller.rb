class SessionsController < ApplicationController
  def create
    session[:current_user] = request.env['omniauth.auth']
    
    User.create_or_update_user_from_omniauth(request.env['omniauth.auth'])
    redirect_to session[:after_auth_url] || home_url
  end
  
  def new
  end
end
