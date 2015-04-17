class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :auth_hash
  helper_method :authed_user
  helper_method :authed_receptionist
  helper_method :authed_administrator
  # before_filter :enforce_auth ## Use this in your own controllers hidden behind auths.
  # before_filter :enforce_superuser ## Use this in your own controllers hidden behind auths.
  
  protected
  
  def enforce_auth
    auth_hash
    
    if auth_hash.blank?
      session[:after_auth_url] = request.url
      session[:current_user] = nil
      redirect_to '/sessions/new'
      return false
    end
    return true
  end
  
  def enforce_superuser    
    if !enforce_auth
      return false
    end
    
    if !authed_user || !authed_user.superuser 
      session[:after_auth_url] = request.url
      session[:current_user] = nil
      flash[:notice] = 'You need to be an admin to see that.'
      redirect_to '/'
      return false
    end
    return true
  end

  def set_authed_org_membership
    return nil if @org.nil? && params[:org_id].nil? # org doesn't exist, so ignore
    
    org = @org || Org.find_by_permalink(params[:org_id])
    return nil unless org
    
    @org_membership = org.memberships.where(user_id: authed_user.id).first
    return nil unless @org_membership
    return @org_membership
  end
  
  def set_authed_location_membership
    return nil if @org.nil? || (@location.nil? && params[:location_id].nil?) # location doesn't exist, so ignore
    
    location = @location || @org.locations.find_by_permalink(params[:location_id])
    return nil unless location
    
    @location_membership = location.memberships.where(user_id: authed_user.id).first
    return nil unless @location_membership
    return @location_membership
  end
  
  def set_authed_membership
    @authed_membership ||= begin
      set_authed_org_membership || set_authed_location_membership # org membership overrides location membership always, so find that first
    end
  end
  
  def enforce_org_receptionist
    if !authed_receptionist
      render :text => "Sorry, you aren't authorized to access this page.", :status => :unauthorized
      return false
    else
      return true
    end
  end

  def enforce_org_administrator
    if !authed_administrator
      render :text => "Sorry, you aren't authorized to access this page.", :status => :unauthorized
      return false
    else
      return true
    end
  end
  
  def auth_hash
    request.env['omniauth.auth']
  end
  
  def authed_receptionist
    @authed_receptionist ||= begin
      membership = set_authed_membership
      if !authed_user
        false
      elsif (!membership || !membership.reception?) && !enforce_org_administrator && !authed_user.superuser
        false
      else
        true
      end
    end
  end

  def authed_administrator
    @authed_administrator ||= begin
      membership = set_authed_membership
      if !authed_user
        false
      elsif (!membership || !membership.administration?) && !authed_user.superuser
        false
      else
        true
      end
    end
  end
  
  def authed_user
    @authed_user ||= begin
      if !session[:current_user].blank?
        User.find_by_id(session[:current_user].to_s.to_i)
      elsif auth_hash.blank?
        nil
      else
        existing_user = User.find_from_omniauth(auth_hash)
        unless existing_user
          existing_user = User.create_or_update_user_from_omniauth(auth_hash)
        end
        existing_user
      end
    end
  end
end
