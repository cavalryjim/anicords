# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  file_path  :string(255)
#  animal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Document < ActiveRecord::Base
  belongs_to :animal
  
  mount_uploader :file_path, FileUploader
  
  def document_path
    file_path.path
  end
  
  def display_title
    if self.title == nil || self.title == ''
      self.file_path.file.filename
    else
      self.title
    end
  end
  
end
