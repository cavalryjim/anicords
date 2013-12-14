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
    image "#{Rails.root}/app/assets/images/dooliddl_f.png", at: [bounds.right - 200, bounds.top], width: 200
    text_box "www.dooliddl.com", at: [bounds.right - 150, bounds.top - 56], style: :bold
    text "#{@animal}", size: 30, style: :bold 
    text "#{@animal.owner.name}", size: 20, style: :bold 
    text "#{@owner.phone}", size: 15 if @owner.phone
  end
  
  def demographics
    move_down 10
    text "#{@animal.species_long_name}"
    text "breed: #{@animal.breed}" if @animal.breed
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