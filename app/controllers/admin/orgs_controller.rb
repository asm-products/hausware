class Admin::OrgsController < ApplicationController
  before_action :set_org
  before_filter :enforce_auth
  before_filter :enforce_org_administrator
  
  
  # GET /orgs/1/edit
  def edit
  end

  # PATCH/PUT /orgs/1
  # PATCH/PUT /orgs/1.json
  def update
    respond_to do |format|
      if @org.update(org_params)
        format.html { redirect_to @org, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @org }
      else
        format.html { render :edit }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy
    @org.destroy
    respond_to do |format|
      format.html { redirect_to orgs_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
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
