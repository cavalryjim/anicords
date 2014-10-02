class HouseholdAssociationsController < ApplicationController
  before_action :set_household_association, only: [:destroy, :update]
  before_action :set_household, only: [:create, :destroy]
  before_filter :authenticate_user!
  authorize_resource

  def create
    @household_association = HouseholdAssociation.find_or_initialize_by(household_association_params)
    @success = @household_association.save 
    respond_to do |format| 
      format.js
    end
  end
  
  def update
    @success = @household_association.update(household_association_params)
    respond_to do |format|
      format.js 
    end
  end

  # DELETE /household_associations/1
  # DELETE /households/1.json
  def destroy
    @success = @household_association.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to @household }
      format.json { head :no_content }
    end
  end
  
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_household_association
      @household_association = HouseholdAssociation.find(params[:id])
    end
    
    def set_household
      if params[:household_id].present?
        @household = Household.find(params[:household_id])
      else
        @household = @household_association.household 
      end
    end
    
    def household_association_params
      params.require(:household_association).permit(:id, :household_id, :provider_id, :provider_type )
    end
end
