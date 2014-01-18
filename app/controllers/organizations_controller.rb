class OrganizationsController < InheritedResources::Base
  before_action :set_organization, only: [:show, :edit, :update, :destroy, :create_user]
  before_filter :authenticate_user!
  authorize_resource
  
  def index
    redirect_to root_url
  end
  
  # GET /organizations/new
  def new
    @organization = Organization.new
    
    #1.times { @organization.animals.build }
  end
  
  # GET /organizations/1
  # GET /organizations/1.json
  def show
    respond_to do |format|     
      format.html
      format.json
    end

  end

  # GET /organizations/1/edit
  def edit
  end
  
  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    respond_to do |format|
      if @organization.save && @organization.associate_user(current_user.id)
        session[:home_page] = organization_path(@organization)
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end
  
  def create_user
    current_user.create_user_to_group(params[:user][:email], @organization.id, @organization.class.name, params[:user][:first_name], params[:user][:last_name] )
    
    redirect_to edit_organization_path(@organization), notice: 'Human was successfully added.'
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :address1, :address2, :phone, :user_associations_attributes, :city, :state, :zip,
        animals_attributes: [:name, :animal_type_id, :organization, :organization_id, :_destroy])
    end
  
end
