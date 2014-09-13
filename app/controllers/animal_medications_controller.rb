class AnimalMedicationsController < ApplicationController
  before_action :set_animal, only: [:create, :destroy]
  before_action :set_animal_medication, only: [:destroy]
  before_filter :authenticate_user!
  authorize_resource
  
  def create
    (params[:animal_medication][:medication_id] = Medication.new_submission(params[:animal_medication][:medication_id], @animal.animal_type_id)) unless (params[:animal_medication][:medication_id]).blank? 
    @heartworm = (params[:commit] == "add treatment")
    @animal_medication = AnimalMedication.new(animal_medication_params)
    #JDavis: this is not getting set....need to fix.  jdhere.
    @success = @animal_medication.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @heartworm = true if params[:hw].present? && (params[:hw] == 'true')
    
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
                   :notification_count, :notify, :notify_on, :location, :lot_number, :medication_type)
    end
end
