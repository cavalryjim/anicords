# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  #include Sprockets::Helpers::RailsHelper
  #include Sprockets::Helpers::IsolatedHelper

  #storage :file

  #def store_dir
  #  "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  #end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  
  process resize_to_fit: [600, 600]
  
  
  #version :large do
  #  resize_to_limit(600, 600)
  #end

end
