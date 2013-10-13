class ServicesController < ApplicationController
  def index
    
    if params[:spt]
      #@services = Service.find_all_by_service_provider_type_id(params[:spt])
      @services = Service.where(service_provider_type_id: params[:spt]).all
    else
      @services = Service.all
      #@services = nil
    end
    
    render json: @services.collect {|s| {id: s.id, text: s.name }}
  end
  
end
