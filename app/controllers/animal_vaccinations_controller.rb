class AnimalVaccinationsController < ApplicationController
  before_action :set_animal, only: [:create, :destroy]
  before_action :set_animal_vaccination, only: [:destroy]
  before_filter :authenticate_user!
  authorize_resource
  
  def create
    vaccination = Vaccination.find(params[:animal_vaccination][:vaccination_id])
    if vaccination.series_name.present? && vaccination.series_number != 999
      @animal_vaccination = AnimalVaccination.where(animal_id: params[:animal_vaccination][:animal_id], vaccination_id: vaccination.id).first_or_initialize
      @animal_vaccination.update(animal_vaccination_params)
    else 
      @animal_vaccination = AnimalVaccination.new(animal_vaccination_params)
    end
    @animal_vaccination.set_due_date if @animal_vaccination.vaccination.frequency.present?
    
    respond_to do |format|
      if @animal_vaccination.save 
        @animal_vaccination.update_series if @animal_vaccination.vaccination_series?
        format.js
      end
    end
  end
  
  def destroy
    @animal_vaccination.destroy
    respond_to do |format|
      #format.html { redirect_to @household }
      #format.json { head :no_content }
      format.js
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:animal_id])
    end
    
    def set_animal_vaccination
      @animal_vaccination = AnimalVaccination.find(params[:id])
    end
    
    def animal_vaccination_params
      params.require(:animal_vaccination).permit(:animal_id, :vaccination_id, :vaccination_date, :dosage, :tag_number, :location)
    end
  
end
