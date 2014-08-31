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
  has_many   :sitter_responses, dependent: :destroy
  
  validates_presence_of :start_datetime
  validates_presence_of :end_datetime
  
  after_create :create_responses
  
  def name
    title.present? ? title : ((start_datetime.to_date.to_s) + ' to ' + (end_datetime.to_date.to_s))
  end
  
  def notify_sitters(sender)
    household.pet_sitters.each do |sitter|
      UserMailer.sitter_request(sitter, self, sender).deliver 
    end
  end
  
  private
  
  def create_responses
    self.household.pet_sitters.each do |sitter|
      #SitterResponse.update_or_create(sitter_request_id: self.id, user_id: sitter.id, response: 'none')
      SitterResponse.where(sitter_request_id: self.id, user_id: sitter.id, response: 'awaiting response').first_or_create
    end
    
  end
  
end
