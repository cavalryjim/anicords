# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  image      :string(255)
#  animal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Picture < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :animal
  mount_uploader :image, ImageUploader
  #mount_uploader :image, FileUploader
  
  validates_presence_of :animal_id
  validates_presence_of :key

  before_create :default_name

  def default_name
    self.name ||= File.basename(image.filename, '.*').titleize if image
  end
  
  def image_path
    image.path
  end
end
