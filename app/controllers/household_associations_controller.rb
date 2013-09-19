class HouseholdAssociationsController < ApplicationController
  before_action :set_household_association
  before_action :set_household

  

  # DELETE /household_associations/1
  # DELETE /households/1.json
  def destroy
    @household_association.destroy
    respond_to do |format|
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
      @household = Household.find(params[:household_id])
    end
end
