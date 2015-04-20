class Account::ReservationsController < ApplicationController
  before_filter :enforce_auth
  
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = authed_user.reservations.all
  end
end
