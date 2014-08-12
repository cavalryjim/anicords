class AnimalMedicationsController < ApplicationController
  before_action :set_animal, only: [:create, :destroy]
  before_action :set_animal_medication, only: [:destroy]
  before_filter :authenticate_user!
  authorize_resource
  
  def create
    @animal_medication = AnimalMedication.new(animal_medication_params)
    if params[:heartworm_id].present?
      @animal_medication.medication_id = params[:heartworm_id] 
      @heartworm = true
    end
    @animal_medication.set_due_date if @animal_medication.medication.frequency.present?
    
    respond_to do |format|
      if @animal_medication.save 
        format.js
      else
        breakage
      end
    end
  end
  
  def destroy
    @animal_medication.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:animal_id])
    end
    
    def set_animal_medication
      @animal_medication = AnimalMedication.find(params[:id])
    end
    
    def animal_medication_params
      params.require(:animal_medication).permit(:animal_id, :medication_id, :volume, :route, :interval, :medication_date, :medication_due, 
                   :notification_count, :notify, :notify_on, :location, :lot_number)
    end
end
