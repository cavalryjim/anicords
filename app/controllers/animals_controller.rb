class AnimalsController < ApplicationController
  before_action :authenticate_user!, except: [ :show, :microchip_lookup, :contact_owner ]
  before_action :set_animal, only: [:show, :edit, :update, :destroy, :download_file, :transfer_ownership, :accept_transfer, :cancel_transfer,
                                      :sitter_instructions, :org_flyer, :photo_gallery, :weight_chart, :check_in, :check_out, :contact_owner,
                                      :dog_facts ]
  before_action :set_owner, only: [:new, :show, :create, :edit, :update, :destroy, :transfer_ownership, :sitter_instructions, :org_flyer,
                                      :contact_owner ]
  
  authorize_resource except: [:accept_transfer, :show, :microchip_lookup, :contact_owner ]
  
  # GET /animals
  # GET /animals.json
  def index
    redirect_to user_select_association_path
  #  @animals = Animal.all
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
    if current_user && current_user.animal_transfers.map{|at| at.animal_id}.include?(@animal.id)
      @transfer_id = AnimalTransfer.where(animal_id: @animal.id, transferee: current_user).first.id 
    end
    
    respond_to do |format|
      format.js
      format.html
      format.pdf do
        pdf = MedicalRecordPdf.new(@animal)
        send_data pdf.render, filename: "#{@owner}_#{@animal}.pdf",
                type: "application/pdf", disposition: "inline"
      end
    end

  end

  # GET /animals/new
  def new
    @animal = Animal.new
    @animal.build_org_profile if @owner.class.name == "Organization"
  end

  # GET /animals/1/edit
  def edit
    #if (@owner && @owner.class.name == "Organization")
    #  @organization = @owner
    #end
  end

  # POST /animals
  # POST /animals.json
  def create
    params[:animal][:breed_ids] = Animal.fix_breed_ids(params[:animal][:breed_ids]) if (params[:animal][:breed_ids]).present?
    @animal = Animal.new(animal_params)
    @animal.set_org_location if ((@animal.owner.class.name == "Organization") && @animal.org_profile.organization_location_id.blank?)
    @location_options = @organization.organization_locations.map{|l| [ l.id, l.name ]} if @organization.present?
    
    respond_to do |format|
      if @animal.save! 
        @animal.create_qr_code(animal_url(@animal, qrc: 'true'))
        #@animal.create_activity :create, owner: current_user, recipient: @animal.owner
        format.html { redirect_to return_path, notice: 'Animal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @animal }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    # JDavis: all of this params fix stuff needs to be moved elsewhere
    #params[:animal] = @animal.inspect_params(params[:animal])  <--- such as here.
    (params[:animal][:food_id] = Food.new_submission(params[:animal][:food_id], params[:animal][:animal_type_id])) unless ((params[:animal][:food_id]).blank? || (Integer(params[:animal][:food_id]) rescue false))
    (params[:animal][:shampoo_id] = Shampoo.new_submission(params[:animal][:shampoo_id], params[:animal][:animal_type_id])) unless ((params[:animal][:shampoo_id]).blank? || (Integer(params[:animal][:shampoo_id]) rescue false))
    (params[:animal][:treat_id] = Treat.new_submission(params[:animal][:treat_id], params[:animal][:animal_type_id])) unless ((params[:animal][:treat_id]).blank? || (Integer(params[:animal][:treat_id]) rescue false))
    (params[:animal][:vitamin_id] = Vitamin.new_submission(params[:animal][:vitamin_id], params[:animal][:animal_type_id])) unless ((params[:animal][:vitamin_id]).blank? || (Integer(params[:animal][:vitamin_id]) rescue false))
    # JDavis: Select2 is a pain and insists upon screwing up the submission of selected items.  This is a fix.
    (params[:animal][:medical_diagnosis_ids] = @animal.fix_ids(params[:animal][:medical_diagnosis_ids])) if (params[:animal][:medical_diagnosis_ids]).present?
    (params[:animal][:medication_ids] = @animal.fix_ids(params[:animal][:medication_ids])) if (params[:animal][:medication_ids]).present?
    (params[:animal][:allergy_ids] = @animal.fix_ids(params[:animal][:allergy_ids])) if (params[:animal][:allergy_ids]).present?
    (params[:animal][:personality_type_ids] = @animal.fix_ids(params[:animal][:personality_type_ids])) if (params[:animal][:personality_type_ids]).present?
    (params[:animal][:breed_ids] = @animal.fix_ids(params[:animal][:breed_ids])) if (params[:animal][:breed_ids]).present?
    #params[:animal][:food_ids] = @animal.fix_ids(params[:animal][:food_ids])
    
    if @organization.present?
      @location_options = @organization.organization_locations.map{|l| [ l.id, l.name ]}
      @animal.build_org_profile unless @animal.org_profile.present?
      @animal.org_profile.organization_location_id ||= @organization.organization_locations.first.id
    end
    
    respond_to do |format|
      if @animal.update(animal_params)
        @animal.create_qr_code(animal_url(@animal, qrc: 'true')) if (@animal.qr_code.blank? || @animal.qr_code_date.blank?)
        #@animal.create_activity :update, owner: current_user
        format.html { redirect_to return_path, notice: @animal.name + ' was successfully updated.' }
        format.json { head json: return_path }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    if params[:archive].present? 
      @animal.archive
    else
      @animal.destroy
    end
    respond_to do |format|
      format.html { redirect_to @owner, notice: 'Animal was successfully removed.' }
      format.json { head :no_content }
      format.js
    end
  end
  
  def download_file
    file = open(@animal.pedigree.url)
    send_file(file, disposition: "attachment")
  end
  
  def transfer_ownership
    @success = ((params[:transferee][:email] == params[:transferee][:email2]) && params[:transferee][:email].match(/^\S+@\S+\.\S+$/))
    if @success
      transferee_id = @animal.transfer_ownership(params[:transferee], animal_url(@animal.id) + "?transfer=true" ) 
      @animal.create_qr_code(animal_url(@animal, qrc: 'true')) if (@animal.qr_code.blank? || @animal.qr_code_date.blank?)
      @owner.capture_transfer(@animal.id, transferee_id, params[:transferee], params[:org] ) if @owner.class.name == 'Organization'
      if @animal.owner.class.name == "Household"
        @household = @animal.owner 
        @animals = @household.all_animals
      end
    end
    
    respond_to do |format|
      format.js 
    end
  end
  
  def cancel_transfer
    @success = @animal.cancel_transfer
    if @animal.owner.class.name == "Household"
      @household = @animal.owner 
      @animals = @household.all_animals
    end
    respond_to do |format|
      format.js 
    end
  end
  
  def accept_transfer
    # JDavis: need to move this logic to the animal model.  jdhere.
    association = UserAssociation.find(params[:association])
    transfer = AnimalTransfer.find(params[:animal_transfer_id])
    notice = 'There was a problem with the transfer.'

    @animal.owner = association.group
    @animal.build_org_profile if (association.group.class.name == 'Organization' && @animal.org_profile.blank? )
    if can?(:change_owner, @animal) && @animal.save
      transfer.destroy if transfer
      notice = 'Animal was successfully transferred.' 
    end
    
    redirect_to association.group, notice: notice
  end
  
  def sitter_instructions
    respond_to do |format|
      format.pdf do
        pdf = SitterInstructionsPdf.new(@animal)
        send_data pdf.render, filename: "#{@animal}_sitter_instructions.pdf",
                type: "application/pdf", disposition: "inline"
      end
    end
  end
  
  def org_flyer
    #@organization = Organization.find(params[:organization_id])
    respond_to do |format|
      format.pdf do
        pdf = OrgFlyerPdf.new(@animal, @organization)
        send_data pdf.render, filename: "#{@animal}_flyer.pdf",
                type: "application/pdf", disposition: "inline"
      end
    end
  end
  
  def dog_facts
    respond_to do |format|
      format.pdf do
        pdf = DogFactsPdf.new(@animal)
        send_data pdf.render, filename: "#{@animal}_dog_facts.pdf",
                type: "application/pdf", disposition: "inline"
      end
    end
  end
  
  def weight_chart
    respond_to do |format|
      format.js 
    end
  end
  
  def check_in
    if params[:service_provider_id].present?
      @animal_association = AnimalAssociation.where(animal_id: @animal.id, service_provider_id: params[:service_provider_id]).first_or_create
    end
    
    respond_to do |format|
      format.js 
    end
  end
  
  def check_out
    if params[:service_provider_id].present?
      @animal_association = AnimalAssociation.where(animal_id: @animal.id, service_provider_id: params[:service_provider_id]).first_or_create
    end
    respond_to do |format|
      format.js 
    end
  end
  
  def microchip_lookup
    @animals = Animal.microchip_search(params[:chip_brand], params[:chip_id]) 
    #@animals = Animal.first(5)
    respond_to do |format|
      format.js 
    end
  end
  
  def contact_owner
    params[:sender_id].present? || params[:sender_id] = nil
    @success = @animal.contact_owner(params[:message], params[:sender_id], params[:sender_name], params[:sender_contact])

    respond_to do |format|
      format.js 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end
    
    def set_owner
      if @animal && @animal.owner.present?
        @owner = @animal.owner
      end 
      
      if params[:household_id]
        @household = Household.find(params[:household_id])
        @custodian = @household
      elsif params[:organization_id]
        @organization = Organization.find(params[:organization_id])
        @custodian = @organization
      elsif params[:breeder_id]
        @breeder = Breeder.find(params[:breeder_id])
        @custodian = @breeder
      end
      
      @owner ||= @custodian if @custodian.present?
    end
    
    def return_path
      case @animal.owner.class.name
      when 'Organization'
        organization_path(@animal.owner.id)
      when 'Household'
        edit_household_animal_path(@animal.owner.id, @animal.id)
        #polymorphic_path([@animal.owner, @animal], action: :edit)
      else
        animal_path(@animal.id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      #params.require(:animal).permit!
      params.require(:animal).permit(:name, :animal_type_id, :breed, :description, :household_id, :breeder_id,
       :dob, :pedigree, :store_dir, :remove_pedigree, :show_name, :registration_number, :pedigree_chart, :health_certification,
       :vaccination_record, :shampoo_id, :vitamin_id, :treat_id, :remove_health_certification, :remove_vaccination_record,
       :volume_per_serving, :serving_measure, :servings_per_day, :gender, :neutered, :food_id, 
       :microchip_id, :special_instructions, :owner_id, :owner_type, :owner, :neutered_date, :registration_club_id,
       :fur_color, :organization_id, :size, :avatar_uid, :avatar_name, :avatar, :microchip_brand, :microchipped, :pedigreed,
       :neuter_location, :microchip_brand_id,
       :medical_diagnosis_ids, :medication_ids, :allergy_ids, :personality_type_ids, :breed_ids,
       org_profile_attributes: [ :id, :animal_id, :intake_date, :intake_reason, :organization_location_id, :neuter_location_id,
         :neuter_location_type, :neuter_location, :petfinder_id, :org_animal_id,    
         :thumbnail_url, :adoption_date, :transferee_first_name, :transferee_last_name, :transferee_phone,
         :transferee_city, :transferee_state, :transferee_zip, :_destroy],
       health_profile_attributes: [ :id, :animal_id, :last_exam_date, :last_exam_location, :heartworm_test_date,     
         :heartworm_test_location, :heartworm_test_result, :fiv_felv_test_date, :fiv_felv_test_location,  
         :fiv_felv_test_result, :_destroy],
       weight_attributes: [ :id, :measure_num, :measure_unit, :measure_date, :animal_id, :_destroy],
       medical_diagnosis_ids: [], medication_ids: [], allergy_ids: [], personality_type_ids: [], breed_ids: [] )
    end
end

