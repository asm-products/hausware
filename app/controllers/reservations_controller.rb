class ReservationsController < ApplicationController
  before_action :set_org
  before_action :set_location
  before_action :set_space
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = @space.reservations.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    starts = @location.opening_time_on(Time.now.advance(days: 1)) # first thing tomorrow
    @reservation = @space.reservations.build(user: authed_user, starts_at: starts, ends_at: starts.advance(hours: 1), timezone: @location.timezone)
    if authed_user
      @reservation.name = authed_user.full_name
      @reservation.email = authed_user.email
      @reservation.phone = authed_user.phone
      @reservation.zipcode = authed_user.zipcode
      @reservation.save_details_for_next_time = true
    end
  end

  # POST /reservations/validate.json
  def validate
    @reservation = @space.reservations.build(reservation_params.merge(user: authed_user))
    
    respond_to do |format|
      if @reservation.valid?
        format.json { render json: { valid: true, errors: nil, reservation: @reservation }, status: :ok }
      else
        format.json { render json: { valid: false, errors: @reservation.errors, reservation: @reservation }, status: :ok }
      end
    end
  end
  
  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = @space.reservations.build(reservation_params.merge(user: authed_user))

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to [@reservation.space.location.org, @reservation.space.location, @reservation.space, @reservation], notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: [@reservation.space.location.org, @reservation.space.location, @reservation.space, @reservation] }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
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
    def set_space
      @space = @location.spaces.find_by_permalink(params[:space_id])
      raise ActiveRecord::RecordNotFound unless @space
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = @space.reservations.find_by_confirmation(params[:id])
      raise ActiveRecord::RecordNotFound unless @reservation
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:name, :email, :phone, :zipcode, :starts_at, :ends_at, :stripe_token, :save_details_for_next_time, :timezone)
    end
end
