class OrgsController < ApplicationController
  before_action :set_org, only: [:show]
  before_filter :enforce_auth, only: [:new, :create]

  # GET /orgs
  # GET /orgs.json
  def index
    @orgs = Org.all
  end

  # GET /orgs/1
  # GET /orgs/1.json
  def show
  end

  # GET /orgs/new
  def new
    @org = authed_user.orgs.build
  end


  # POST /orgs
  # POST /orgs.json
  def create
    @org = authed_user.orgs.build(org_params)

    respond_to do |format|
      if @org.save
        format.html { redirect_to @org, notice: 'Org was successfully created.' }
        format.json { render :show, status: :created, location: @org }
      else
        format.html { render :new }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find_by_permalink(params[:id])
      raise ActiveRecord::RecordNotFound unless @org
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def org_params
      params.require(:org).permit(:name, :permalink, :url, :email, :phone)
    end
end
