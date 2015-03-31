class SessionsController < ApplicationController
  def create
    session[:current_user] = request.env['omniauth.auth']
    User.create_or_update_user_from_omniauth(request.env['omniauth.auth'])
    redirect_to session[:after_auth_url] || root_url
  end
  
  def new
  end
  
  def destroy
    session[:current_user] = nil
    session[:after_auth_url] = nil
    flash[:notice] = "Logged out – see you next time!"
    redirect_to root_url
  end
end
