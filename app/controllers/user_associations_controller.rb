class UserAssociationsController < ApplicationController
  before_action :set_user_association
  before_filter :authenticate_user!
  authorize_resource

  # DELETE /household_associations/1
  # DELETE /households/1.json
  def destroy
    @user_association.destroy
    
    if params[:household_id]
      redirect_path = edit_household_path(params[:household_id])
    elsif params[:user_id]
      redirect_path = edit_user_path(params[:user_id])
    elsif params[:organization_id]
      redirect_path = edit_organization_path(params[:organization_id])
    else
      redirect_path = edit_user_path(current_user)
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
