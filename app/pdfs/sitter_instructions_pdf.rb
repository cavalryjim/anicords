class SitterInstructionsPdf < Prawn::Document
  def initialize(animal)
    super()
    @animal = animal
    @owner = animal.owner
    top_header
    demographics
    feeding_info
    special_instructions
  end
  
  def top_header
    image "#{Rails.root}/app/assets/images/petabyt_f.png", at: [bounds.right - 200, bounds.top], width: 200
    text_box "www.petabyt.com", at: [bounds.right - 150, bounds.top - 56], style: :bold
    text "#{@animal}", size: 30, style: :bold 
    image open("#{ @animal.qr_code.remote_url }"), at: [bounds.right - 300, bounds.top], width: 90 if @animal.qr_code.present? 
    text "#{@animal.owner.name}", size: 20, style: :bold 
    text "#{@owner.phone}", size: 15 if @owner.phone
  end
  
  def demographics
    move_down 10
    text "#{@animal.species_long_name}"
    text "breed: #{@animal.breed_names}" if @animal.breeds.count > 1
    text "neutered / spayed: #{@animal.fixed}"
    text "description: #{@animal.description}" if @animal.description
  end
  
  def feeding_info
    move_down 15
    text "Feeding Information", size: 20, style: :bold 
    text "Preferred food: #{@animal.food_preference}"
    text "#{@animal.feeding_comment}"
  end
  
  def special_instructions
    move_down 15
    text "Special Instructions", size: 20, style: :bold 
    text "#{@animal.special_instructions}"
  end
  
end
