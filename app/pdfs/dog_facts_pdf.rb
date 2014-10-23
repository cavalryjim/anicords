class DogFactsPdf < Prawn::Document
  def initialize(animal)
    super()
    @animal = animal
    @owner = animal.owner
    #font "http://fonts.googleapis.com/css?family=Life+Savers"
    top_header
    demographics
    vaccinations
    ownership_costs
    bottom_footer
  end
  
  def top_header
    #image "#{Rails.root}/app/assets/images/animal_minder2.png", at: [bounds.right - 200, bounds.top], width: 200
    #text_box "www.animalminder.com", at: [bounds.right - 150, bounds.top - 56], style: :bold
    text "DogFacts on #{@animal}", size: 30, style: :bold 
    image open("#{ @animal.avatar.remote_url }"), at: [bounds.right - 150, bounds.top-25], width: 90 if @animal.avatar.present?
    
    #text "#{@animal.owner.name}", size: 20, style: :bold 
    #text "#{@owner.phone}", size: 15 if @owner.phone.present?
    
    
    #gap = 20
    #bounding_box([0, cursor], :width => 500, :height => 200) do
    #  box_content("Fixed height")
    #  bounding_box([gap, cursor - gap], :width => 300) do
    #    text "Stretchy height"
    #    bounding_box([gap, bounds.top - gap], :width => 100) do
    #      text "Stretchy height"
    #      transparent(0.5) { dash(1); stroke_bounds; undash }
    #    end
    #    bounding_box([gap * 7, bounds.top - gap], :width => 100, :height => 50) do
    #      box_content("Fixed height")
    #    end
    #    transparent(0.5) { dash(1); stroke_bounds; undash }
    #  end
    #  bounding_box([gap, cursor - gap], :width => 300, :height => 50) do
    #   box_content("Fixed height")
    #  end
    #end
    
  end
  
  def box_content(string)
    text string
    transparent(0.5) { stroke_bounds }
  end
  
  def demographics
    move_down 10
    #bounding_box([0, cursor], :width => 250) do
    text "microchip id: #{@animal.microchip_info}" if @animal.microchip_id.present?
    text "animalminder id: #{@animal.id}"
    text "species: #{@animal.species_long_name}"
    text "breed: #{@animal.breed_names}" if @animal.breeds.count > 1
    text "neutered / spayed: #{@animal.fixed.downcase}"
    #text "description: #{@animal.description}" if @animal.description.present?
    #end
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
  
  def ownership_costs
    move_down 15
    table cost_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end
  
  def cost_rows
    [["item", "estimated annual cost"]] +
    @animal.animal_vaccinations.map do |vaccination|
      [vaccination.name, vaccination.date]
    end
  end
  
  def bottom_footer
    image open("#{ @animal.qr_code.remote_url }"), at: [bounds.right - 250, bounds.bottom + 50], width: 90 if @animal.qr_code.present? 
  end
  
end