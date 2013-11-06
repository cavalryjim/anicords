class RemoteRequestsController < ApplicationController
  
  def vitamins
    if params[:vit]
      @vitamin = Vitamin.find(params[:vit])
      render json: @vitamin, only: [:id], methods: [:text]
    elsif params[:vits]
      @vitamins = Vitamin.where(id: params[:vits]).all.map{|v| {id: v.id, text: v.name }}
      render json: @vitamins
    else
      @vitamins = Vitamin.order(:name).where("name like ?", "%#{params[:term]}%").map{|v| {id: v.id, text: v.name }}
      render json: @vitamins
    end
  end
  
end
