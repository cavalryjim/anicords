class Breeder < ActiveRecord::Base
  
  has_many  :user_associations, :dependent => :destroy
  has_many  :users, :through => :user_associations
  has_many  :animals
  accepts_nested_attributes_for :animals, allow_destroy: true
  
end
