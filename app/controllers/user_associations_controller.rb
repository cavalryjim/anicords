class UserAssociationsController < ApplicationController
  before_action :set_user_association, except: [:create]
  before_filter :authenticate_user!
  authorize_resource
  
  def edit
    @user = @user_association.user
    @roles = @user.group_roles(@user_association.group)
    respond_to do |format|
      format.js
    end
  end
  
  def create
    if params[:user][:household_id].present?
      @household = Household.find(params[:user][:household_id]) 
      @group = @household
      @sitter_page = (params[:commit] == 'add sitter')
    elsif params[:user][:organization_id].present?
      @organization = Organization.find(params[:user][:organization_id])
      @group = @organization
    end
    
    User.add_user_to_group(@group, params[:user_roles], params[:user][:email],
      params[:user][:first_name], params[:user][:last_name], params[:user][:phone])
    #new_user.create_activity :added_to_group, owner: current_user, recipient: @household
    
    respond_to do |format|
      format.js
      #format.html { redirect_to edit_household_path(@household), notice: 'Human was successfully added.' }
      #format.json { head :no_content }
    end
  end
  
  def update
    
  end

  # DELETE /household_associations/1
  # DELETE /households/1.json
  def destroy
    @user_association.destroy
    
    if params[:household_id]
      @household = Household.find(params[:household_id])
      redirect_path = edit_household_path(params[:household_id])
    elsif params[:user_id]
      redirect_path = edit_user_path(params[:user_id])
    elsif params[:organization_id]
      redirect_path = edit_organization_path(params[:organization_id])
    else
      redirect_path = edit_user_path(current_user)
    end
    
    respond_to do |format|
      format.js
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
