class Admin::LocationsController < ApplicationController
  before_action :set_org
  before_filter :enforce_auth
  before_filter :enforce_org_administrator
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations/new
  def new
    @location = @org.locations.build
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = @org.locations.build(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to [:admin, @location.org, @location], notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @location.org, @location] }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end
  
  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to [:admin, @location.org, @location], notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @location.org, @location] }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, @location.org], notice: 'Location was successfully destroyed.' }
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
    @location = @org.locations.find_by_permalink(params[:id])
    raise ActiveRecord::RecordNotFound unless @location
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:name, :permalink, :phone, :email, :timezone, :latitude, :longitude, :street_address1, :street_address2, :city, :state_province_region, :zip_postal_code, :country_code, :sunday_opening, :sunday_closing, :monday_opening, :monday_closing, :tuesday_opening, :tuesday_closing, :wednesday_opening, :wednesday_closing, :thursday_opening, :thursday_closing, :friday_opening, :friday_closing, :saturday_opening, :saturday_closing)
  end
end
