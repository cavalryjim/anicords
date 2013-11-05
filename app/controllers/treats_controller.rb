class TreatsController < ApplicationController
  
  def index
    
    if params[:trt]
      @treat = Treat.find(params[:trt])
      render json: @treat, only: [:id], methods: [:text]
    elsif params[:trts]
      #@services = Service.find_all_by_service_provider_type_id(params[:spt])
      @treats = Treat.where(id: params[:trts]).all.map{|t| {id: t.id, text: t.name }}
      render json: @treats
    else
      @treats = Treat.order(:name).where("name like ?", "%#{params[:term]}%").map{|t| {id: t.id, text: t.name }}
      render json: @treats
    end
    
  end
  
  
end
