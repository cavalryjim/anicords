class UserAssociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :breeder
  
end
