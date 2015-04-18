class SpacesController < ApplicationController
  before_action :set_org
  before_action :set_location
  before_action :set_space, only: [:show]

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = @location.spaces.all
  end

  # GET /spaces/1
  # GET /spaces/1.json
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
    @location = @org.locations.find_by_permalink(params[:location_id])
    raise ActiveRecord::RecordNotFound unless @location
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_space
    @space = @location.spaces.find_by_permalink(params[:id])
    raise ActiveRecord::RecordNotFound unless @space
  end

end
