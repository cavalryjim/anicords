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
  #mount_uploader :image, ImageUploader
  #mount_uploader :image, FileUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  
  validates_presence_of :animal_id
  validates_presence_of :key

  before_create :default_name
  
  dragonfly_accessor :image do
    storage_options do |attachment|
      { path: "images/#{Rails.env}/animal_#{animal_id}/#{id}_#{image_name}" }
    end
  end

  def default_name
    self.name ||= File.basename(image.filename, '.*').titleize if image
  end
  
  def image_path
    image.path
  end
  
  def crop(x,y,w,h)
    require 'RMagick'

    img = Magick::ImageList.new(self.image_url)
    cropped_img = img.crop(x, y, w, h)
    cropped_img = cropped_img.resize_to_fill(50, 50)
    animal = self.animal
    
    if cropped_img
      animal.update_attribute :avatar, cropped_img
    end
  end
  
end
