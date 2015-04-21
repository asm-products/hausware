class SlidesController < ApplicationController
  before_action :set_org
  before_action :set_location
  before_action :set_space
  before_action :set_slide, only: [:show]
  
  # GET /slides
  # GET /slides.json
  def index
    @slides = @space.slides.all
  end

  # GET /slides/1
  # GET /slides/1.json
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
      @space = @location.spaces.find_by_permalink(params[:space_id])
      raise ActiveRecord::RecordNotFound unless @space
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_slide
      @slide = @space.slides.find(params[:id])
    end
end
