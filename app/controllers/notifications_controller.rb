class NotificationsController < ApplicationController
  before_action :set_notification, only: [:destroy]
  before_action :set_animal, only: [:destroy]
  before_filter :authenticate_user!
  authorize_resource
  
  def destroy
    @notification.destroy
    respond_to do |format|
      format.js
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      if @notification.animal.present?
        @animal = @notification.animal
      elsif params[:animal_id].present?
        @animal = Animal.find(params[:animal_id])
      else
        @animal = false
      end 
      
    end
    
    def set_notification
      @notification = Notification.find(params[:id])
    end
    
    def notification_params
      params.require(:notification).permit(:animal_id, :id, :recipient_id, :recipient_type, :recipient, :message, :url,           
        :event_id, :event_type, :event, :active)
    end
end
