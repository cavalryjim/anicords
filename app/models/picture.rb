# == Schema Information
#
# Table name: pictures
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  animal_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#  image_uid    :string(255)
#  image_name   :string(255)
#  external_url :string(255)
#

class Picture < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :animal
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
   
  validates_presence_of :animal_id
  validate :image_xor_external_url
  validates_size_of :image, maximum: 2048.kilobytes
  validates_property :format, of: :image, in: ['jpeg', 'jpg', 'png', 'gif']
  

  #before_create :default_name
  
  dragonfly_accessor :image do
    storage_options do |attachment|
      { path: "images/#{Rails.env}/animal_#{animal_id}/#{rand(36**5).to_s(36)}_#{image_name}" }
    end
    after_assign { |pic| self.image = pic.thumb('600x600>', 'format' => 'jpg') } # JDavis: resize the picture to 600x600
  end

  #def default_name
  #  self.name ||= File.basename(image.filename, '.*').titleize if image
  #end
  
  def image_path
    image.path
  end
  
  def image_location
    image.present? ? image.url : external_url
  end
  
  def crop(x,y,w,h)
    #puts x
    return false unless self.image.present?
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
  
  private
  
  def image_xor_external_url
    unless (image.blank? ^ external_url.blank?)
      errors.add(:base, "Need an image or URL.")
      #"not good"
    end
  end
  
end
