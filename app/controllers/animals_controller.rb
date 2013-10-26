class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy, :download_file]
  before_action :set_owner, only: [:new, :create, :edit, :destroy]
  before_filter :authenticate_user!, except: [:show]

  # GET /animals
  # GET /animals.json
  def index
    @animals = Animal.all
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
    
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
    @uploader.success_action_redirect = url_for([@owner, @animal]) + '/edit'
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)
    
    respond_to do |format|
      if @animal.save 
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
    respond_to do |format|
      if @animal.update(animal_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end
    
    def set_owner
      if params[:household_id]
        @owner = Household.find(params[:household_id])
      elsif params[:breeder_id]
        @owner = Breeder.find(params[:breeder_id])
      end
    end
    
    def return_path
      if params[:household_id]
        edit_household_animal_path(params[:household_id], @animal.id)
      elsif params[:breeder_id]
        edit_breeder_animal_path(params[:breeder_id], @animal.id)
      else
        edit_animal_path(@animal.id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      params.require(:animal).permit(:name, :animal_type_id, :breed, :weight, :description, :household_id, :breeder_id,
       :dob, :pedigree, :store_dir, :remove_pedigree, :show_name, :registration_number, :image, :pedigree_chart, :health_certification, 
       :vaccination_record, :shampoo, :vitamin, :treat, :remove_health_certification )
    end
end
