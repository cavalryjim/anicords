class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:home, :login, :privacy_policy ] 
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    #@user = current_user
    #@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: @user )
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        #UserMailer.signup_confirmation(@user).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path(@user.id), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def home
    #JDavis: this action will need logic to determine which household or breeder to redirect the routing
    if current_user && current_user.no_associations?
      redirect_to user_select_account_type_path
    elsif current_user && current_user.multiple_associations?
      redirect_to user_select_association_path
    elsif current_user 
      redirect_to current_user.user_associations.first.group
    else
      redirect_to new_user_registration_path
    end
  end
  
  def select_association
    @user = current_user
  end
  
  def set_association
    redirect_to session[:home_page]
  end
  
  def select_account_type
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :middle_name, :last_name, :email, :address1, :address2, :city, :state, :zip, :phone, :provider, :uid)
    end
end
