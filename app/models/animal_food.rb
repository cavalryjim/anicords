class AnimalFood < ActiveRecord::Base
  belongs_to :animal
  belongs_to :food
  
  def name
    self.food.name
  end
  
end
