class MedicalRecordPdf < Prawn::Document
  def initialize(animal)
    super()
    @animal = animal
    top_header
    demographics
    vaccinations
  end
  
  def top_header
    image "#{Rails.root}/app/assets/images/dooliddl_f.png", at: [bounds.right - 200, bounds.top], width: 200
    text "#{@animal}", size: 30, style: :bold 
  end
  
  def demographics
    move_down 10
    text "#{@animal.species_long_name}"
    text "breed: #{@animal.breed}" if @animal.breed
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
  
end