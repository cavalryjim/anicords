class OrganizationsController < InheritedResources::Base
  before_action :set_organization, except: [:index, :new, :create ]
  before_filter :authenticate_user!
  authorize_resource 
  
  def index
    redirect_to root_url
  end
  
  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @animal = Animal.new
    @animal.build_org_profile
    @animals = @organization.animals
    @location_options = @organization.organization_locations.map{|l| [ l.id, l.name ]}
    @notifications = @organization.notifications
    #@notifications = Notification.all
  end
  
  # GET /organizations/new
  def new
    @organization = Organization.new
    
    #1.times { @organization.animals.build }
  end

  # GET /organizations/1/edit
  def edit
  end
  
  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    respond_to do |format|
      if @organization.save && @organization.associate_user(current_user.id, true)
        User.create_user_to_group(params[:admin1_email], @organization, params[:admin1_first_name], params[:admin1_last_name], true ) if (params[:admin1_email].present?)
        User.create_user_to_group(params[:admin2_email], @organization, params[:admin2_first_name], params[:admin2_last_name], true ) if (params[:admin2_email].present?)
        
        format.html { redirect_to organization_path(@organization), notice: 'Organization was successfully created.' }
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
        format.html { redirect_to edit_organization_path(@organization), notice: 'Organization was successfully updated.' }
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
    User.create_user_to_group(params[:user][:email], @organization, params[:user][:first_name], params[:user][:last_name], params[:user][:admin] )
    
    redirect_to edit_organization_path(@organization), notice: 'Human was successfully added.'
  end
  
  def petfinder_import
    notice = @organization.petfinder_import if @organization.petfinder_shelter_id.present?
    
    redirect_to @organization, notice: notice
  end
  
  def adoptions
    @adoptions = @organization.adoptions
  end
  
  def new_foster_home
    @foster_home = Household.return_foster_home(params[:home])
    if @foster_home
      @foster_home.associate_user(params[:foster_user_id]) 
      @organization.associate_location(@foster_home)
    end
    
  end
  
  def new_foster_user
    @good_email = (params[:foster][:email] == params[:foster][:email2]) && params[:foster][:email].match(/^\S+@\S+\.\S+$/)
    if @good_email
      @foster_user = User.return_foster_user(params[:foster])
    end
  end
  
  def select_foster_home
    @foster_home = Household.find(params[:household])
    @organization.associate_location(@foster_home) if @foster_home
  end
  
  def import_animals
    if params[:file].present?
      notice = @organization.spreadsheet_import(params[:file])
    else
      notice = "No file was selected."
    end
    
    redirect_to @organization, notice: notice
  end
  
  def vaccinations_report
    @as_of_date = params[:as_of_date].to_date
    @animal_vaccinations = @organization.animal_vaccinations_due( @as_of_date )
    @xls = (params[:format] == "xls")
    
    respond_to do |format|
      format.js
      format.xls
    end
    
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :address1, :address2, :phone, :user_associations_attributes, 
        :city, :state, :zip, :petfinder_shelter_id, :logo_external_url,
        animals_attributes: [:name, :animal_type_id, :organization, :organization_id, :owner, :owner_id, :owner_type, :_destroy])
    end
  
end
