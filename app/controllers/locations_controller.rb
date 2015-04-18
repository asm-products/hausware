class LocationsController < ApplicationController
  before_action :set_org
  before_action :set_location, only: [:show]

  # GET /locations
  # GET /locations.json
  def index
    @locations = @org.locations
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
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

end
