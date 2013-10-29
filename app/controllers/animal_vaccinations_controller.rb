class AnimalVaccinationsController < ApplicationController
  before_action :set_animal, only: [:create, :destroy]
  before_action :set_animal_vaccination, only: [:create, :destroy]
  
  
  def create
    
  end
  
  def destroy
    @animal_vaccination.destroy
    respond_to do |format|
      format.html { redirect_to @household }
      format.json { head :no_content }
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:animal_id])
    end
    
    def set_animal_vaccination
      @animal_vaccination = AnimalVaccination.find[:animal_vaccination_id]
    end
  
end
