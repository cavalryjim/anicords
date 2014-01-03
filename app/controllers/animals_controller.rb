class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy, :download_file, :transfer_ownership, :accept_transfer, 
                                      :sitter_instructions, :photo_gallery]
  before_action :set_owner, only: [:new, :show, :create, :edit, :destroy, :transfer_ownership, :sitter_instructions]
  before_filter :authenticate_user!, except: [:show]
  authorize_resource except: [:accept_transfer]
  
  # GET /animals
  # GET /animals.json
  def index
    @animals = Animal.all
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
    @transfer_id = AnimalTransfer.where(animal_id: @animal.id, transferee: current_user).first.id if current_user.animal_transfers.map{|at| at.animal_id}.include?(@animal.id)
    
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
  end

  # GET /animals/1/edit
  def edit
    if params[:key]
      Document.create(animal_id: @animal.id, key: params[:key])
    end
    @uploader = Document.new.file_path
    #@uploader.success_action_redirect = url_for([@owner, @animal]) + '/edit'
    @uploader.success_action_redirect = polymorphic_path([@owner, @animal], method: :edit)
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)
    respond_to do |format|
      if @animal.save 
        @animal.create_qr_code(animal_url(@animal))
        @animal.create_activity :create, owner: current_user, recipient: @animal.owner
        format.html { redirect_to return_path, notice: 'Animal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @animal }
      else
        format.html { render action: 'new' }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    params[:animal][:food_id] = @animal.create_new_food(params[:animal][:food_id]) unless (Integer(params[:animal][:food_id]) rescue false)
    # JDavis: Select2 is a pain and insists upon screwing up the submission of selected items.  This is a fix.
    params[:animal][:medical_diagnosis_ids] = @animal.fix_ids(params[:animal][:medical_diagnosis_ids])
    params[:animal][:medication_ids] = @animal.fix_ids(params[:animal][:medication_ids])
    params[:animal][:allergy_ids] = @animal.fix_ids(params[:animal][:allergy_ids])
    #params[:animal][:food_ids] = @animal.fix_ids(params[:animal][:food_ids])
    
    respond_to do |format|
      if @animal.update(animal_params)
        @animal.create_qr_code(animal_url(@animal))unless @animal.qr_code.present?
        #@animal.create_activity :update, owner: current_user
        format.html { redirect_to return_path, notice: @animal.name + ' was successfully updated.' }
        format.json { head json: return_path }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to @owner, notice: 'Animal was successfully updated.' }
      format.json { head :no_content }
    end
  end
  
  def download_file
    file = open(@animal.pedigree.url)
    send_file(file, disposition: "attachment")
     #send_file(@animal.pedigree.direct_fog_url(with_path: true),
     #   :disposition => 'attachment',
     #   :url_based_filename => true)
     #redirect_to @animal.pedigree.url, :target => "_blank"
     
     #open(@animal.pedigree.url) {|file|
     #  tmpfile = Tempfile.new("download.jpg")
     #  File.open(tmpfile.path, 'wb') do |f| 
     #    f.write img.read
     #  end 
     #  send_file tmpfile.path, :filename => "great-image.jpg"
     # }   
     
  end
  
  def transfer_ownership
    @success = (params[:transferee_email] == params[:transferee_email2]) && params[:transferee_email].match(/^\S+@\S+\.\S+$/)
    
    @animal.transfer_ownership(params[:transferee_email], params[:first_name], params[:last_name], animal_url(@animal.id)) if @success
    
    respond_to do |format|
      format.js 
    end
  end
  
  def accept_transfer
    association = UserAssociation.find(params[:association])
    transfer = AnimalTransfer.find(params[:animal_transfer_id])
    notice = 'There was a problem with the transfer.'

    @animal.owner = association.group
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
  
  def photo_gallery
    Picture.create(animal_id: @animal.id, key: params[:key]) if params[:key]
    
    #@pictures = @animal.pictures
    @uploader = Picture.new.image
    @uploader.success_action_redirect = animal_photo_gallery_url(@animal)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end
    
    def set_owner
      if @animal && @animal.owner
        @owner = @animal.owner
      elsif params[:household_id]
        @owner = Household.find(params[:household_id])
      elsif params[:organization_id]
        @owner = Organization.find(params[:organization_id])
      elsif params[:breeder_id]
        @owner = Breeder.find(params[:breeder_id])
      end
    end
    
    def return_path
      if @animal.owner
        #edit_household_animal_path(params[:household_id], @animal.id)
        polymorphic_path([@animal.owner, @animal], action: :edit)
      else
        edit_animal_path(@animal.id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      #params.require(:animal).permit!
      params.require(:animal).permit(:name, :animal_type_id, :breed, :weight, :description, :household_id, :breeder_id,
       :dob, :pedigree, :store_dir, :remove_pedigree, :show_name, :registration_number, :image, :pedigree_chart, :health_certification,
       :vaccination_record, :shampoo_id, :vitamin_id, :treat_id, :remove_health_certification, :remove_vaccination_record,
       :volume_per_serving, :serving_measure, :servings_per_day, :weight_measure, :breed_id, :gender, :neutered, :food_id, 
       :rfid, :special_instructions, :owner_id, :owner_type, :owner, :neutered_date, :registration_club_id,
       :fur_color, :disposition,
       :medical_diagnosis_ids, :medication_ids, :allergy_ids, medical_diagnosis_ids: [], medication_ids: [], allergy_ids: [] )
    end
end
