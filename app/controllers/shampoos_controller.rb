class ShampoosController < ApplicationController
  
  def index
    
    if params[:shpo]
      @shampoo = Shampoo.find(params[:shpo])
      render json: @shampoo, only: [:id], methods: [:text]
    elsif params[:shpos]
      #@services = Service.find_all_by_service_provider_type_id(params[:spt])
      @shampoos = Shampoo.where(id: params[:shpos]).all.map{|s| {id: s.id, text: s.name }}
      render json: @shampoos
    else
      @shampoos = Shampoo.order(:name).where("name like ?", "%#{params[:term]}%").map{|s| {id: s.id, text: s.name }}
      render json: @shampoos
    end
    
    #render json: @medical_diagnoses.collect {|s| {id: s.id, text: s.name }}
    
    
  end
  
end
