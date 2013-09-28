class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]
  before_action :set_owner, only: [:new, :create]

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
        format.html { redirect_to @owner, notice: 'Animal was successfully created.' }
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
        format.html { redirect_to @animal.owner, notice: @animal.name + ' was successfully updated.' }
        format.json { head :no_content }
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
      format.html { redirect_to @animal.owner, notice: 'Animal was successfully updated.' }
      format.json { head :no_content }
    end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      params.require(:animal).permit(:name, :animal_type_id, :breed, :weight, :description, :household_id, :breeder_id, :dob)
    end
end