class RemoteRequestsController < ApplicationController
  before_filter :authenticate_user!
  
  def allergies
    if params[:alg]
      @allergies = Allergy.where(id: params[:alg]).all.map{|a| {id: a.id, text: a.name }}
    else
      @allergies = Allergy.order(:name).where("name ILIKE ?", "%#{params[:term]}%").map{|a| {id: a.id, text: a.name }}
    end
    render json: @allergies
  end
  
  def breeds
    if params[:brd]
      @breed = Breed.find(params[:brd])
      render json: @breed, only: [:id], methods: [:text]
    elsif params[:brds]
      @breeds = Breed.where(id: params[:brds]).all.map{|s| {id: s.id, text: s.name }}
      render json: @breeds
    else
      n = "%#{params[:term]}%"
      a = "#{params[:at_id]}"
      @breeds = Breed.order(:name).where("name ILIKE ? and animal_type_id = ?", n, a).map{|s| {id: s.id, text: s.name }}
      render json: @breeds
    end
  end
  
  def registration_clubs
    if params[:clb]
      @club = RegistrationClub.find(params[:clb])
      render json: @club, only: [:id], methods: [:text]
    elsif params[:clbs]
      @clubs = RegistrationClub.where(id: params[:clbs]).all.map{|s| {id: s.id, text: s.name }}
      render json: @clubs
    else
      n = "%#{params[:term]}%"
      a = "#{params[:at_id]}"
      @clubs = RegistrationClub.order(:name).where("name ILIKE ? and animal_type_id = ?", n, a).map{|s| {id: s.id, text: s.name }}
      render json: @clubs
    end
  end
  
  def foods 
    if params[:fd]
      @food = Food.find(params[:fd])
      render json: @food, only: [:id], methods: [:text]
    elsif params[:at_id]
      n = "%#{params[:term]}%"
      a = "#{params[:at_id]}"
      @foods = Food.order(:name).where("name ILIKE ? AND animal_type_id = ?", n, a).map{|f| {id: f.id, text: f.name }}
      render json: @foods
    else
      @foods = Food.order(:name).where("name ILIKE ?", "%#{params[:term]}%").map{|f| {id: f.id, text: f.name }}
      render json: @foods
    end
  end
  
  def medical_diagnoses
    if params[:md]
      @medical_diagnoses = MedicalDiagnosis.where(id: params[:md]).all.map{|d| {id: d.id, text: d.name }}
    else
      n = "%#{params[:term]}%"
      a = "#{params[:at_id]}"
      @medical_diagnoses = MedicalDiagnosis.order(:name).where("name ILIKE ? and animal_type_id = ?", n, a).map{|d| {id: d.id, text: d.name }}
    end
    render json: @medical_diagnoses
  end
  
  def medications
    if params[:meds]
      @medications = Medication.where(id: params[:meds]).all.map{|m| {id: m.id, text: m.name }}
    else
      @medications = Medication.order(:name).where("name ILIKE ?", "%#{params[:term]}%").map{|m| {id: m.id, text: m.name }}
    end
    render json: @medications
  end
  
  def services
    if params[:spt]
      @services = Service.where(service_provider_type_id: params[:spt]).all
    else
      @services = Service.all
    end
    render json: @services.collect {|s| {id: s.id, text: s.name }}
  end
  
  def shampoos
    if params[:shpo]
      @shampoo = Shampoo.find(params[:shpo])
      render json: @shampoo, only: [:id], methods: [:text]
    elsif params[:shpos]
      @shampoos = Shampoo.where(id: params[:shpos]).all.map{|s| {id: s.id, text: s.name }}
      render json: @shampoos
    else
      @shampoos = Shampoo.order(:name).where("name ILIKE ?", "%#{params[:term]}%").map{|s| {id: s.id, text: s.name }}
      render json: @shampoos
    end
  end
  
  def treats
    if params[:trt]
      @treat = Treat.find(params[:trt])
      render json: @treat, only: [:id], methods: [:text]
    elsif params[:trts]
      @treats = Treat.where(id: params[:trts]).all.map{|t| {id: t.id, text: t.name }}
      render json: @treats
    else
      @treats = Treat.order(:name).where("name ILIKE ?", "%#{params[:term]}%").map{|t| {id: t.id, text: t.name }}
      render json: @treats
    end
    
  end
  
  def vaccinations
    @vaccinations = Vaccination.order(:name).where("name ILIKE ?", "%#{params[:term]}%").map{|v| {id: v.id, text: v.name }}
    render json: @vaccinations
  end
  
  def vitamins
    if params[:vit]
      @vitamin = Vitamin.find(params[:vit])
      render json: @vitamin, only: [:id], methods: [:text]
    elsif params[:vits]
      @vitamins = Vitamin.where(id: params[:vits]).all.map{|v| {id: v.id, text: v.name }}
      render json: @vitamins
    else
      @vitamins = Vitamin.order(:name).where("name ILIKE ?", "%#{params[:term]}%").map{|v| {id: v.id, text: v.name }}
      render json: @vitamins
    end
  end
  
end
