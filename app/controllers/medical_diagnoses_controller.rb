class MedicalDiagnosesController < ApplicationController
  
  def index
    
    if params[:md]
      #@services = Service.find_all_by_service_provider_type_id(params[:spt])
      @medical_diagnoses = MedicalDiagnosis.where(id: params[:md]).all.map{|d| {id: d.id, text: d.name }}
    else
      @medical_diagnoses = MedicalDiagnosis.order(:name).where("name like ?", "%#{params[:term]}%").map{|d| {id: d.id, text: d.name }}
    end
    
    #render json: @medical_diagnoses.collect {|s| {id: s.id, text: s.name }}
    
    
    render json: @medical_diagnoses
  end
  
end
