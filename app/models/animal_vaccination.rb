# == Schema Information
#
# Table name: animal_vaccinations
#
#  id                 :integer          not null, primary key
#  animal_id          :integer
#  vaccination_id     :integer
#  vaccination_date   :date
#  dosage             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  vaccination_due    :date
#  tag_number         :string(255)
#  notification_count :integer          default(0)
#  notify             :boolean          default(TRUE)
#  notify_on          :date
#

class AnimalVaccination < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :animal
  belongs_to :vaccination
  has_many   :notifications, as: :event, dependent: :destroy
  
  validates_presence_of :animal_id
  validates_presence_of :vaccination_id
  validates_presence_of :vaccination_date
  
  before_create do
    self.remove_vaccination_notifications
  end
  
  def name
    self.vaccination.name
  end
  
  def date
    self.vaccination_date
  end
  
  def due
    self.vaccination_due
  end
  
  def self.create_vaccination_notifications
    vaccinations = AnimalVaccination.where(notify_on: Date.today)
    num = 0
    vaccinations.each do |vaccination|
      msg = vaccination.name + " vaccination due."
      animal = vaccination.animal
      vaccination.notifications.create(message: msg, animal_id: animal.id, recipient: animal.owner  )
      vaccination.update_attributes(notify_on: 5.days.from_now.to_date, notification_count: (vaccination.notification_count += 1))
      animal.send_vaccination_notification(msg)
      num += 1
    end
    return num
  end
  
  def remove_vaccination_notifications
    animal_vaccination =  AnimalVaccination.where(animal_id: self.animal_id, vaccination_id: self.vaccination_id).last
    if animal_vaccination.present?
      animal_vaccination.update_attributes(notify_on: nil)
      animal_vaccination.notifications.destroy_all 
    end 
  end
  
  def set_due_date
    frequency = self.vaccination.frequency.days
    self.vaccination_due = self.vaccination_date + frequency 

    if frequency > 30.days
      self.notify_on = self.vaccination_due - 30.days
    else 
      self.notify_on = self.vaccination_due - (frequency / 2.days)
    end
  end
  
  
    
end
