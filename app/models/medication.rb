# == Schema Information
#
# Table name: medications
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  medication_type    :string(255)
#  animal_type_id     :integer
#  series_name        :string(255)
#  series_number      :integer
#  series_interval    :integer
#  series_next_id     :integer
#  recommended_dosage :string(255)
#  frequency          :integer
#  route              :string(255)
#  chronic            :boolean          default(FALSE)
#  nada_id            :string(255)
#  produced_by        :string(255)
#  description        :text
#  side_effects       :text
#

class Medication < ActiveRecord::Base
  belongs_to  :animal_type
  
  has_many :animals, through: :animal_medications
  has_many :animal_medications
  
  validates_presence_of :name
  
  def series?
    series_name.present?
  end
  
  def chronic?
    self.chronic
  end
  
end
