class Reception::ReservationsController < ApplicationController
  # before_filter :enforce_auth
  before_action :set_org
  before_action :set_location
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = @location.reservations.all
  end
  
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_org
    @org = Org.find_by_permalink(params[:org_id])
    raise ActiveRecord::RecordNotFound unless @org
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = @org.locations.find_by_permalink(params[:location_id])
    raise ActiveRecord::RecordNotFound unless @location
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = @location.reservations.find_by_confirmation(params[:id])
    raise ActiveRecord::RecordNotFound unless @reservation
  end
end
