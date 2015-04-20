class Admin::SettingsController < ApplicationController
  before_action :set_org
  before_filter :enforce_auth
  before_filter :enforce_org_administrator
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /settings
  # GET /settings.json
  def index
    @settings = [@org.setting]
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
  end

  # GET /settings/new
  def new
    @setting = @org.build_setting
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = @org.build_setting(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to [:admin, @setting.org, @setting], notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @setting.org, @setting] }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to [:admin, @setting.org, @setting], notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @setting.org, @setting] }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, @setting.org], notice: 'Setting was successfully destroyed.' }
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
    def set_setting
      @setting = @org.setting
      raise ActiveRecord::RecordNotFound unless @org.setting.id.to_s == params[:id].to_s
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:space_id, :stripe_publishable_key, :stripe_secret_key_unencrypted)
    end
end
