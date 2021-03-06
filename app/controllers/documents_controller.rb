class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :download_file, :email]
  before_action :set_animal, only: [:create, :update, :destroy]
  authorize_resource

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    
    respond_to do |format|
      if @document.save 
        @success = true
        format.html { redirect_to return_path, notice: 'Document was successfully uploaded.' }
        format.json { render action: 'show', status: :created, location: @document }
        format.js
      else
        @success = false
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to return_path, notice: @document.name + ' was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to return_path, notice: 'Document was successfully removed.' }
      format.json { head :no_content }
      format.js
    end
  end
  
  def download_file
    url = @document.file_path.path
    send_file( url, :disposition => 'inline' )
  end
  
  def email
    if params[:recipient_email].present? && params[:recipient_email].match(/^\S+@\S+\.\S+$/)
      @document.email_me(params[:recipient_email])
      @success = true
    else
      @success = false
    end
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
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :animal_id, :file, :file_uid, :file_name, :file_type, :external_url)
    end
  
end
