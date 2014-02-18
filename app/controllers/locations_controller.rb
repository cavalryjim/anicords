class LocationsController < ApplicationController
  before_action :set_organization
  before_filter :authenticate_user!
  authorize_resource
  
  def index
    @locations = @organization.locations
    @fosters = @organization.households
  end
  
  def new
    @location = Location.new
    
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :address1, :address2, :phone, :email, :city, :state, :zip, :website  )
    end
end
