class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy, :download_file]
  before_action :set_animal, only: [:create, :update, :destroy]

  

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    
    respond_to do |format|
      if @picture.save 
        format.html { redirect_to return_path, notice: 'Picture was successfully uploaded.' }
        format.json { render action: 'show', status: :created, location: @picture }
      else
        format.html { render action: 'new' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to return_path, notice: @picture.name + ' was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to return_path, notice: 'Picture was successfully removed.' }
      format.json { head :no_content }
    end
  end
  
  def download_file
    url = @picture.file_path.path
    send_file( url, :disposition => 'inline' )
     #require 'open-uri'
     #url = @picture.file_path.url
     #data = open(url).read
     #send_data data, :disposition => 'attachment', :filename=> @picture.file_path.file.filename
     
  end

  private
    def set_animal
      if params[:animal_id]
        @animal = Animal.find(params[:animal_id])
        
      end
    end
    
    def return_path
      if params[:household_id]
        edit_household_animal_path(params[:household_id], @animal.id)+'#panel2'
      elsif params[:breeder_id]
        edit_breeder_animal_path(params[:breeder_id], @animal.id)
      else
        edit_animal_path(@animal.id)+'#panel2'
      end
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:name, :image, :animal_id, :file_path, :store_dir)
    end
  
end
