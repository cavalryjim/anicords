# == Schema Information
#
# Table name: documents
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  animal_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#  file_type    :string(255)
#  file_uid     :string(255)
#  file_name    :string(255)
#  external_url :string(255)
#

class Document < ActiveRecord::Base
  belongs_to :animal
  
  validates_presence_of :animal_id
  validates_size_of :file, maximum: 2048.kilobytes
  #validates_property :format, of: :file, in: ['pdf', 'tiff', 'doc', 'docx', 'xls', 'xlsx', 'zip']
  validate :file_xor_external_url
  
  dragonfly_accessor :file do
    storage_options do |attachment|
      { path: "documents/#{Rails.env}/animal_#{animal_id}/#{rand(36**5).to_s(36)}_#{file_name}" }
    end
  end
  
  def file_path
    file.path
  end
  
  def file_location
    file.present? ? file.url : external_url
  end
  
  private
  
  def file_xor_external_url
    unless (file.blank? ^ external_url.blank?)
      errors.add(:base, "Need a file or URL.")
    end
  end
  
end
