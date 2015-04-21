class Admin::SlidesController < ApplicationController
  before_action :set_org
  before_filter :enforce_auth
  before_filter :enforce_org_administrator
  before_action :set_location
  before_action :set_space
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  # GET /slides
  # GET /slides.json
  def index
    @slides = @space.slides.all
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
  end

  # GET /slides/new
  def new
    no_slides = @space.slides.count == 0
    @slide = @space.slides.build({order: @space.slides.count+1})
    @slide.set_as_cover = no_slides # set as cover by default if it's the first one
  end

  # GET /slides/1/edit
  def edit
  end

  # POST /slides
  # POST /slides.json
  def create
    @slide = @space.slides.build(slide_params)

    respond_to do |format|
      if @slide.save
        format.html { redirect_to [:admin, @space.location.org, @space.location, @space, @slide], notice: 'Slide was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @space.location.org, @space.location, @space, @slide] }
      else
        format.html { render :new }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slides/1
  # PATCH/PUT /slides/1.json
  def update
    respond_to do |format|
      if @slide.update(slide_params)
        format.html { redirect_to [:admin, @space.location.org, @space.location, @space, @slide], notice: 'Slide was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @space.location.org, @space.location, @space, @slide] }
      else
        format.html { render :edit }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, @space.location.org, @space.location, @space, :slides], notice: 'Slide was successfully destroyed.' }
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
    def set_space
      @space = @location.spaces.find_by_permalink(params[:space_id])
      raise ActiveRecord::RecordNotFound unless @space
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_slide
      @slide = @space.slides.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slide_params
      params.require(:slide).permit(:picture, :order, :caption)
    end
end
