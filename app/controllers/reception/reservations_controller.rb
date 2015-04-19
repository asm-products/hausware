class Reception::ReservationsController < ApplicationController
  before_action :set_org
  before_filter :enforce_auth
  before_filter :enforce_org_receptionist
  before_action :set_location
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = @location.reservations.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end


  # GET /reservations/1/edit
  def edit
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to [:reception, @reservation.space.location.org, @reservation.space.location, @reservation.space, @reservation], notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: [:reception, @reservation.space.location.org, @reservation.space.location, @reservation.space, @reservation] }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reception_org_location_space_reservations_url(@reservation.space.location.org, @reservation.space.location, @reservation.space), notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
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
