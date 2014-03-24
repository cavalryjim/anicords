class WeightsController < ApplicationController
  before_action :set_animal, only: [:create, :destroy]
  before_action :set_weight, only: [:destroy]
  before_filter :authenticate_user!
  authorize_resource
  
  def create
    @weight = Weight.new(weight_params)
    
    respond_to do |format|
      if @weight.save 
        format.js
      end
    end
  end
  
  def destroy
    @weight.destroy
    respond_to do |format|
      format.js
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:animal_id])
    end
    
    def set_weight
      @weight = Weight.find(params[:id])
    end
    
    def weight_params
      params.require(:weight).permit(:animal_id, :measure_num, :measure_unit, :measure_date)
    end
  
end
