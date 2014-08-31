# == Schema Information
#
# Table name: sitter_requests
#
#  id                  :integer          not null, primary key
#  household_id        :integer
#  start_datetime      :datetime
#  end_datetime        :datetime
#  comments            :text
#  confirmed_sitter_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class SitterRequest < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :household
  
  validates_presence_of :start_datetime
  validates_presence_of :end_datetime
  
  def name
    (start_datetime.to_date.to_s) + ' to ' + (end_datetime.to_date.to_s)
  end
  
  def notify_sitters
    
  end
  
end
