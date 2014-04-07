class AnimalAssociationsController < ApplicationController
  before_action :set_animal, only: [:create, :destroy]
  before_action :set_animal_association, only: [:destroy, :update]
  before_filter :authenticate_user!
  authorize_resource
  
  def create
    @animal_association = AnimalAssociation.find_or_initialize_by(animal_association_params)
    respond_to do |format|
      if @animal_association.save 
        format.js
      end
    end
  end
  
  def update
    respond_to do |format|
      if @animal_association.update(animal_association_params)
        format.js
      else
        format.js
      end
    end
  end
  
  def destroy
    @animal_association.destroy
    respond_to do |format|
      format.js
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:animal_id])
    end
    
    def set_animal_association
      @animal_association = AnimalAssociation.find(params[:id])
    end
    
    def animal_association_params
      params.require(:animal_association).permit(:id, :animal_id, :service_provider_id, :checked_in )
    end
  
end
