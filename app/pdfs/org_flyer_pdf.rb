class OrgFlyerPdf < Prawn::Document
  def initialize(animal, organization)
    super()
    @animal = animal
    @organization = organization
    top_header
    body
    footer
  end
  
  def top_header
    image open("#{@organization.logo_external_url}"), at: [bounds.right - 500, bounds.top], fit: [300,100] if @organization.logo_external_url.present?
    
    image open("#{@animal.qr_code.remote_url}"), at: [bounds.right - 100, bounds.top], width: 90 if @animal.qr_code.present? 
  end
  
  def body
    move_down 110
    text "#{@animal.name}", size: 30, align: :center
    
    image open("#{ @animal.pictures.first.image_location }"), position: :center if @animal.pictures.first.present?
    text "description: #{@animal.description}" if @animal.description.present?
  end
  
  def footer
    move_down 15
    text "www.petabyt.com", size: 20, style: :bold, align: :center 
    
  end
  
  
end
