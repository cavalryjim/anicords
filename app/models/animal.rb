# == Schema Information
#
# Table name: animals
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  animal_type_id     :integer
#  breed              :string(255)
#  weight             :decimal(, )
#  description        :text
#  household_id       :integer
#  breeder_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#  dob                :date
#  food               :string(255)
#  volume_per_serving :decimal(, )
#  servings_per_day   :integer
#

class Animal < ActiveRecord::Base
  
  belongs_to :animal_type
  belongs_to :breeder
  belongs_to :household
  has_many   :documents, :dependent => :destroy
  accepts_nested_attributes_for :documents, allow_destroy: true
  
  validates :name, presence: true 
  validate :owner
  
  def owner
    if self.household_id
      Household.find(self.household_id)
    elsif self.breeder_id
      Breeder.find(self.breeder_id)
    else
      false
    end
  end
  
end
