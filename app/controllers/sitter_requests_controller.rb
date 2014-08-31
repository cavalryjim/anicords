class SitterRequestsController < ApplicationController
  before_action :set_request, except: [:index, :new, :create]
  before_action :set_household
  authorize_resource except: [:response]
  
  def index
  end

  def create
    @request = SitterRequest.new(sitter_request_params)
    
    respond_to do |format|
      if @request.save
        @request.notify_sitters(current_user)
        format.html { redirect_to household_path(@household), notice: 'Sitter request submitted.' }
        #format.json { render action: 'show', status: :created, location: @picture }
      else
        format.html { redirect_to household_path(@household), alert: 'there was a problem.' }
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
  
  def sitter_response
    request_id = @request.id
    sitter_id = params[:user]
    response = params[:response]
    sitter_response = SitterResponse.where(sitter_request_id: request_id, user_id: sitter_id).first_or_create
    sitter_response.response = response
    
    if sitter_response.save
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'Response recieved.' }
      end
    end
    
    
  end
  
  private
    def set_request
      @request = SitterRequest.find(params[:id])
    end
    
    def set_household
      @household = Household.find(params[:household_id])
    end
    
    def sitter_request_params
      params.require(:sitter_request).permit(:title, :household_id, :start_datetime, :end_datetime, :comments, :confirmed_sitter_id  )
      #params.require(:sitter_request).permit!
    end
end
