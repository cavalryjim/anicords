# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  animal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  image_uid  :string(255)
#  image_name :string(255)
#

class Picture < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :animal
  #mount_uploader :image, ImageUploader
  #mount_uploader :image, FileUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
   
  validates_presence_of :animal_id
  validates_presence_of :image
  validates_size_of :image, maximum: 2048.kilobytes
  validates_property :format, of: :image, in: ['jpeg', 'jpg', 'png', 'gif']
  

  #before_create :default_name
  
  dragonfly_accessor :image do
    storage_options do |attachment|
      { path: "images/#{Rails.env}/animal_#{animal_id}/#{rand(36**5).to_s(36)}_#{image_name}" }
    end
  end

  #def default_name
  #  self.name ||= File.basename(image.filename, '.*').titleize if image
  #end
  
  def image_path
    image.path
  end
  
  def image_url
    image.url
  end
  
  def crop(x,y,w,h)
    #puts x
    geometry = w + "x" + h + "+" + x + "+" + y
    img = self.image
    avatar = img.process(:thumb, geometry, 'format' => 'jpg')
    #avatar = img.thumb('100x100', 'format' => 'png')
    #avatar = img_thumb.process(:thumb,'50x50', 'format' => 'png')
    animal = self.animal
    animal.update_attribute :avatar, nil if animal.avatar_stored?
     
    animal.avatar = avatar.process(:thumb, '100x100')
    animal.save
    #Animal.find(self.animal_id).update_attribute :avatar, avatar.url
    
  end
  
end
