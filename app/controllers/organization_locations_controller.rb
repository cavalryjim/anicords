class OrganizationLocationsController < ApplicationController
  before_action :set_organization_location, only: [:destroy]
  before_action :set_organization, only: [:destroy]
  before_filter :authenticate_user!
  authorize_resource
  
  
  def destroy
    @organization_location.destroy
    respond_to do |format|
      format.js
      
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_location
      @organization_location = OrganizationLocation.find(params[:id])
    end
    
    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_location_params
      params.require(:organization_location).permit(:organization_id, :location_id, :location_type, :location )
    end
end
