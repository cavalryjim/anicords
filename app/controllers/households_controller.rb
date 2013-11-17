class HouseholdsController < ApplicationController
  before_action :set_household, only: [:show, :edit, :update, :destroy, :add_service_provider, :create_user]
  before_filter :authenticate_user!
  authorize_resource

  # GET /households
  # GET /households.json
  def index
    @households = Household.all
  end

  # GET /households/1
  # GET /households/1.json
  def show
    #@owner = @household
    @activities = PublicActivity::Activity.order("created_at desc").where( trackable_id: @household.animal_ids, trackable_type: "Animal" ).last(10)
  end

  # GET /households/new
  def new
    @household = Household.new
    #@household.users << current_user
    1.times { @household.animals.build }
  end

  # GET /households/1/edit
  def edit
  end

  # POST /households
  # POST /households.json
  def create
    @household = Household.new(household_params)
    respond_to do |format|
      if @household.save && @household.associate_user(current_user.id)
        current_user.create_user_to_household(params[:human_email], @household.id, params[:human_first_name], params[:human_last_name] ) if (params[:human_email] != "")
        session[:home_page] = household_path(@household)
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
        format.html { redirect_to @household, notice: 'Household was successfully updated.' }
        format.json { head :no_content }
      else
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
      format.html { redirect_to households_url }
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
    current_user.create_user_to_household(params[:user][:email], @household.id, params[:user][:first_name], params[:user][:last_name] )
    
    redirect_to edit_household_path(@household), notice: 'Human was successfully added.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_household
      @household = Household.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def household_params
      params.require(:household).permit(:name, :address1, :address2, :phone, :user_associations_attributes, :city, :state, :zip,
        animals_attributes: [:name, :animal_type_id, :household, :household_id, :_destroy])
    end
end
