class HouseholdsController < ApplicationController
  before_action :set_household, only: [:show, :edit, :update, :destroy, :add_service_provider, :create_user, :external_view]
  before_filter :authenticate_user!
  authorize_resource except: [:external_view]

  # GET /households
  # GET /households.json
  def index
    #@households = Household.all
    redirect_to root_url
  end

  # GET /households/1
  # GET /households/1.json
  def show
    #@owner = @household
    @notifications = @household.notifications.where(active: true)
    #@notifications = Notification.all
    @animals = @household.animals.where(active: true)
  end

  # GET /households/new
  def new
    @household = Household.new
    #@household.users << current_user
    1.times { @household.animals.build } unless current_user.has_pending_transfers?
  end

  # GET /households/1/edit
  def edit
  end

  # POST /households
  # POST /households.json
  def create
    #breakage
    @household = Household.new(household_params)
    respond_to do |format|
      if @household.save && @household.associate_user(current_user, 'member')
        #User.create_user_to_group(params[:human_email], @household, 'member', params[:human_first_name], params[:human_last_name], params[:human_phone]) if (params[:human_email] != "")

        @household.transfer_animals(params[:animal_transfers]) if params[:animal_transfers].present?
        format.html { redirect_to @household, notice: 'Household was successfully created.' }
        format.json { render action: 'show', status: :created, location: @household }
      else
        format.html { render action: 'new' }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /households/1
  # PATCH/PUT /households/1.json
  def update
    respond_to do |format|
      if @household.update(household_params)
        format.js
        format.html { redirect_to edit_household_path(@household), notice: 'Household was successfully updated.' }
        format.json { head :no_content }
      else
        format.js
        format.html { render action: 'edit' }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1
  # DELETE /households/1.json
  def destroy
    @household.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end
  
  def add_service_provider
    @household.associate_service_provider(params[:service_provider_id])
    redirect_to @household, notice: 'Provider was successfully added.'
  end
  
  def remove_service_provider
    @household
  end
  
  def create_user
    new_user = User.create_user_to_group(params[:user][:email], @household, params[:user_role],
      params[:user][:first_name], params[:user][:last_name], params[:user][:phone])
    #new_user.create_activity :added_to_group, owner: current_user, recipient: @household
    
    respond_to do |format|
      format.js
      format.html { redirect_to edit_household_path(@household), notice: 'Human was successfully added.' }
      format.json { head :no_content }
    end
  end
  
  def external_view
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_household
      @household = Household.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def household_params
      params.require(:household).permit(:name, :address1, :address2, :phone, :user_associations_attributes, :city, :state, :zip,
        animals_attributes: [:name, :animal_type_id, :owner, :owner_id, :owner_type, :_destroy])
    end
end
