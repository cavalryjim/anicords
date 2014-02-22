class LocationsController < ApplicationController
  before_action :set_location, only: [:edit, :update, :destroy]
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
  
  
  def edit
  end

  
  def create
    #breakage
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save 
        @organization.associate_location(@location) if @organization.present?
        format.js
        format.html { redirect_to @organization, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.js
        format.html { redirect_to @organization, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1
  # DELETE /households/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to @organization, notice: 'Location has been deleted.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end
    
    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :address1, :address2, :phone, :email, :city, :state, :zip, :website  )
    end
end
