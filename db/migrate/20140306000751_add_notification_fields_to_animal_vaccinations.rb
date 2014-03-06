class AddNotificationFieldsToAnimalVaccinations < ActiveRecord::Migration
  def change
    add_column :animal_vaccinations, :notification_count, :integer, default: 0
    add_column :animal_vaccinations, :notify, :boolean, default: true
    add_column :animal_vaccinations, :notify_on, :date
    
    AnimalVaccination.update_all( {notification_count: 0}, {notify: true} )
  end
  
end
