class MedicalRecordPdf < Prawn::Document
  def initialize(animal)
    super()
    @animal = animal
    @owner = animal.owner
    #font "http://fonts.googleapis.com/css?family=Life+Savers"
    top_header
    demographics
    vaccinations
    feeding_info
  end
  
  def top_header
    image "#{Rails.root}/app/assets/images/animal_minder2.png", at: [bounds.right - 200, bounds.top], width: 200
    text_box "www.animalminder.com", at: [bounds.right - 150, bounds.top - 56], style: :bold
    #image "#{@animal.qr_code.url}", at: [bounds.right - 200, bounds.top], width: 200 if @animal.qr_code
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
  
  def vaccinations
    move_down 21
    table vaccination_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def vaccination_rows
    [["vaccination", "date"]] +
    @animal.animal_vaccinations.map do |vaccination|
      [vaccination.name, vaccination.date]
    end
  end
  
  def feeding_info
    move_down 15
    text "Feeding Information", size: 20, style: :bold 
    text "Preferred food: #{@animal.food_preference}"
    text "#{@animal.feeding_comment}"
    
  end
  
end
