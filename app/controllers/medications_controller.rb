class MedicationsController < ApplicationController
  
  def index
    
    if params[:meds]
      #@services = Service.find_all_by_service_provider_type_id(params[:spt])
      @medications = Medication.where(id: params[:meds]).all.map{|m| {id: m.id, text: m.name }}
    else
      @medications = Medication.order(:name).where("name like ?", "%#{params[:term]}%").map{|m| {id: m.id, text: m.name }}
    end
    
    #render json: @medical_diagnoses.collect {|s| {id: s.id, text: s.name }}
    
    
    render json: @medications
  end
  
end
