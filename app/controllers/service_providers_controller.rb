class ServiceProvidersController < ApplicationController
  before_action :set_service_provider, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:edit, :update]
  # GET /service_providers
  # GET /service_providers.json
  def index
    #@service_providers = ServiceProvider.all
    @service_providers = ServiceProvider.order(:name).where("name like ?", "%#{params[:term]}%")
    
    #render json: @service_providers.map(&:name)
    
    render json: @service_providers
  end

  # GET /service_providers/1
  # GET /service_providers/1.json
  def show
  end

  # GET /service_providers/new
  def new
    @service_provider = ServiceProvider.new
  end

  # GET /service_providers/1/edit
  def edit
  end

  # POST /service_providers
  # POST /service_providers.json
  def create
    @service_provider = ServiceProvider.new(service_provider_params)
    respond_to do |format|
      if @service_provider.save
        User.create_user_to_service_provider(@service_provider.email, @service_provider.id) if @service_provider.has_email?
        return_path = current_user ? @service_provider : new_user_registration_path
        format.html { redirect_to return_path, notice: 'Service provider was successfully created.' }
        format.json { render action: 'show', status: :created, location: @service_provider }
      else
        format.html { render action: 'new' }
        format.json { render json: @service_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_providers/1
  # PATCH/PUT /service_providers/1.json
  def update
    
    respond_to do |format|
      if @service_provider.update(service_provider_params)
        format.html { redirect_to @service_provider, notice: 'Service provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @service_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_providers/1
  # DELETE /service_providers/1.json
  def destroy
    @service_provider.destroy
    respond_to do |format|
      format.html { redirect_to service_providers_url }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_provider
      @service_provider = ServiceProvider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_provider_params
      params.require(:service_provider).permit(:name, :address1, :address2, :city, :state, :zip, :email, :website, :phone, :veterinarian_attributes, :service_provider_type_ids => [], :service_ids => [] )
    end
end
