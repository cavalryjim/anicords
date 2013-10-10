class UserAssociationsController < ApplicationController
  before_action :set_user_association
  

  # DELETE /household_associations/1
  # DELETE /households/1.json
  def destroy
    @user_association.destroy
    
    if params[:household_id]
      @household = Household.find(params[:household_id])
      redirect_path = edit_household_path(@household)
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      redirect_path = edit_user_path(@user)
    else
      redirect_path = edit_user_path(@user_association.user)
    end
    
    respond_to do |format|
      format.html { redirect_to redirect_path, notice: 'Relationship was successfully removed.' }
      format.json { head :no_content }
    end
  end
  
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_association
      @user_association = UserAssociation.find(params[:id])
    end
    
    #def set_user
    #  @user = User.find(params[:user_id])
    #end
  
end
