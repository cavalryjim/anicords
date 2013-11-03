class AllergiesController < ApplicationController
  
  def index
    
    if params[:alg]
      #@services = Service.find_all_by_service_provider_type_id(params[:spt])
      @allergies = Allergy.where(id: params[:alg]).all.map{|a| {id: a.id, text: a.name }}
    else
      @allergies = Allergy.order(:name).where("name like ?", "%#{params[:term]}%").map{|a| {id: a.id, text: a.name }}
    end
    
    #render json: @medical_diagnoses.collect {|s| {id: s.id, text: s.name }}
    
    
    render json: @allergies
  end
  
end
