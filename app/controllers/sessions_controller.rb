class SessionsController < ApplicationController
  def create
    if authed_user.blank?
      User.create_or_update_user_from_omniauth(request.env['omniauth.auth'])
    else 
      authed_user.update_and_connect_omniauth(request.env['omniauth.auth'])
    end

    session[:current_user] = User.find_from_omniauth(request.env['omniauth.auth']).id.to_s
    redirect_to session[:after_auth_url] || root_url
  end
  
  def new
    unless params[:next].blank?
      session[:after_auth_url] = params[:next]
    end
  end
  
  def destroy
    session[:current_user] = nil
    session[:after_auth_url] = nil
    flash[:notice] = "Logged out – see you next time!"
    redirect_to root_url
  end
end
