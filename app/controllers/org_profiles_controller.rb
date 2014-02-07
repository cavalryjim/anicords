class OrgProfilesController < ApplicationController
  before_action :set_org_profile
  before_action :set_animal
  before_filter :authenticate_user!
  authorize_resource 
  
  
  
  def update
    #breakage
    respond_to do |format|
      if @org_profile.update(org_profile_params)
        format.html { redirect_to @org_profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: 'edit' }
        #format.json { render json: @org_profile.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org_profile
      @org_profile = OrgProfile.find(params[:id])
    end
    
    def set_animal
      @animal = Animal.find(params[:animal_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def org_profile_params
      params.require(:org_profile).permit(:id, :organization_location_id)
    end
  
end