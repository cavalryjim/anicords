class SitterRequestsController < ApplicationController
  before_action :set_request, except: [:index, :new, :create]
  before_action :set_household
  authorize_resource
  
  def index
  end

  def create
    @request = SitterRequest.new(sitter_request_params)
    
    respond_to do |format|
      if @request.save
        @request.notify_sitters 
        format.html { redirect_to household_path(@household), notice: 'Sitter request submitted.' }
        #format.json { render action: 'show', status: :created, location: @picture }
      else
        format.html { redirect_to animal_pictures_path(@animal.id), alert: 'File must be a jpg, png, or bmp less than 2mb.' }
        #format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
  end

  def destroy
    @request.destroy
    
    respond_to do |format|
      format.js
    end
  end

  def show
  end
  
  private
    def set_request
      @request = SitterRequest.find(params[:id])
    end
    
    def set_household
      @household = Household.find(params[:household_id])
    end
    
    def sitter_request_params
      params.require(:sitter_request).permit(:household_id, :start_datetime, :end_datetime, :comments, 
                    :confirmed_sitter_id  )
      #params.require(:sitter_request).permit!
    end
end
