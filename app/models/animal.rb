class Animal < ActiveRecord::Base
  
  belongs_to :animal_type
  belongs_to :user
  belongs_to :breeder
end
