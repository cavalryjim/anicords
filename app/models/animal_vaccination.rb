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
#  location           :string(255)
#

class AnimalVaccination < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :animal
  belongs_to :vaccination
  has_many   :notifications, as: :event, dependent: :destroy
  
  validates_presence_of :animal_id
  validates_presence_of :vaccination_id
  #validates_presence_of :vaccination_date
  validate   :vaccination_date_or_vaccination_due
  
  before_create do
    self.remove_vaccination_notifications
  end
  
  #after_create do  #JDavis: this never worked correctly when called from here.
  #   self.update_series if self.vaccination_series?
  #end
  
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
    vaccinations = AnimalVaccination.where(notify_on: Date.today, notify: true)
    num = 0
    vaccinations.each do |vaccination|
      msg = vaccination.name + " vaccination due."
      animal = vaccination.animal
      #vaccination.notifications.create(message: msg, animal_id: animal.id, recipient: animal.owner  )
      # JDavis: need to create a notification for  this!  JDHere.
      msg = animal.name + " has a " + vaccination.name + "vaccination due" 
      (msg << " on " << vaccination.vaccination_due.to_s) if vaccination.vaccination_due.present?
      Notification.where(animal_id: animal.id, event: vaccination, recipient: animal.owner, message: msg).first_or_create 
      vaccination.update_attributes(notify_on: 5.days.from_now.to_date, notification_count: (vaccination.notification_count += 1))
      animal.send_vaccination_notification(msg)
      num += 1
    end
    return num
  end
  
  def remove_vaccination_notifications
    vaccinations =  AnimalVaccination.where(animal_id: self.animal_id, vaccination_id: self.vaccination_id)
    if vaccinations.present?
      vaccinations.update_all(notify: false) 
      
      vaccinations.each do |vaccination|
        vaccination.notifications.destroy_all if vaccination.notifications
      end
      
    end 
  end
  
  def set_due_date(previous_vaccination_date = nil, frequency = nil, series = false)
    frequency = self.vaccination.frequency.days if (frequency == nil)
    
    if series
      self.vaccination_due = previous_vaccination_date + frequency
    else
      self.vaccination_due = self.vaccination_date + frequency unless series
    end

    if frequency > 30.days
      self.notify_on = self.vaccination_due - 30.days
    else 
      self.notify_on = self.vaccination_due - (frequency / 2.days)
    end
  end
  
  def vaccination_series?
    self.vaccination.series?
  end
  
  def update_series
    vaccination = self.vaccination

    if vaccination.series_number == 999
      animal_vaccination = AnimalVaccination.new(animal_id: self.animal_id, vaccination_id: vaccination.series_next_id)
    else
      animal_vaccination = AnimalVaccination.where(animal_id: self.animal_id, vaccination_id: vaccination.series_next_id).first_or_initialize
    end
    
    animal_vaccination.set_due_date(self.vaccination_date, vaccination.series_interval, true)
    animal_vaccination.save
  end
  
private
  
  def vaccination_date_or_vaccination_due 
    errors.add(:base, "Specify a vaccination date.") if (vaccination_date.blank? && vaccination_due.blank?)
  end
  
end
