class VaccinationsController < ApplicationController
  
  def index
    @vaccinations = Vaccination.order(:name).where("name like ?", "%#{params[:term]}%").map{|v| {id: v.id, text: v.name }}
    
    render json: @vaccinations
  end
  
end
