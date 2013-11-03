class Food < ActiveRecord::Base
  has_many  :animal_foods
end
