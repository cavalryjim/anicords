# == Schema Information
#
# Table name: animal_medications
#
#  id                 :integer          not null, primary key
#  animal_id          :integer
#  medication_id      :integer
#  created_at         :datetime
#  updated_at         :datetime
#  volume             :string(255)
#  route              :string(255)
#  interval           :string(255)
#  medication_date    :date
#  medication_due     :date
#  notification_count :integer
#  notify             :boolean          default(TRUE)
#  notify_on          :date
#  location           :string(255)
#  lot_number         :string(255)
#  medication_type    :string(255)
#

class AnimalMedication < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :animal
  belongs_to :medication
  has_many   :notifications, as: :event, dependent: :destroy
  
  validates_presence_of :animal_id
  validates_presence_of :medication_id
  
  before_create do
    self.remove_medication_notifications
    self.set_fields
  end
  
  
  def name
    self.medication.name
  end
  
  def self.create_medication_notifications
    medications = AnimalMedication.where(notify_on: Date.today, notify: true)
    num = 0
    medications.each do |medication|
      msg = medication.name + " medication due."
      animal = medication.animal
      #vaccination.notifications.create(message: msg, animal_id: animal.id, recipient: animal.owner  )
      # JDavis: need to create a notification for  this!  JDHere.
      msg = animal.name + " is due " + medication.name 
      (msg << " on " << medication.medication_due.to_s) if medication.medication_due.present?
      Notification.where(animal_id: animal.id, event: medication, recipient: animal.owner, message: msg).first_or_create 
      medication.update_attributes(notify_on: 5.days.from_now.to_date, notification_count: (medication.notification_count += 1))
      animal.send_medication_notification(msg)
      num += 1
    end
    return num
  end
  
  def remove_medication_notifications
    medications =  AnimalMedication.where(animal_id: self.animal_id, medication_id: self.medication_id)
    if medications.present?
      medications.update_all(notify: false) 
      
      medications.each do |medication|
        medication.notifications.destroy_all if medication.notifications.present?
      end
      
    end 
  end
  
  def set_due_date(previous_medication_date = nil, frequency = nil, series = false)
    frequency = self.medication.frequency.days if (frequency == nil)
    
    if series
      self.medication_due = previous_medication_date + frequency
    else
      self.medication_due = self.medicawtion_date + frequency
    end
  end
  
  def medication_series?
    self.medication.series?
  end
  
  def set_fields
    self.set_due_date if self.medication.frequency.present?
    self.medication_type = self.medication.medication_type
  end
  
end
