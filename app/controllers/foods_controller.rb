class FoodsController < ApplicationController
  
  def index
    
    if params[:fd]
      @food = Food.find(params[:fd])
      render json: @food, only: [:id], methods: [:text]
    elsif params[:fds]
      #@services = Service.find_all_by_service_provider_type_id(params[:spt])
      @foods = Food.where(id: params[:fds]).all.map{|f| {id: f.id, text: f.name }}
      render json: @foods
    else
      @foods = Food.order(:name).where("name like ?", "%#{params[:term]}%").map{|f| {id: f.id, text: f.name }}
      render json: @foods
    end
    
    #render json: @medical_diagnoses.collect {|s| {id: s.id, text: s.name }}
    
    
  end
  
end
