module HouseholdsHelper
  
  def avatar_size
    '100x100'
  end
  
  def progress_bar_classes(animal)
    classes = "radius progress "
    classes << "alert" if animal.profile_completion < 50
    return classes
  end
  
  def remove_provider_path_help(household_id, provider_id)
    association = HouseholdAssociation.where(household_id: household_id, service_provider_id: provider_id).first
    household_household_association_path(household_id, association.id)
  end
  
  def animal_notifications(animal)
    notifications = "<ul class='notifications'>"
    notifications << "<li>Schedule appointments by adding service providers.</li>" if animal.service_providers.count == 0
    notifications << "<li>Recieve alerts regarding heartworm meds or vaccinations by updating the health & wellness tab.</li>" if animal.needs_vaccination_info?
    notifications << "<li>Update feeding preferences to easily send instructions to your kennel or sitter.</li>" if animal.needs_diet_info?
    notifications << "<li>Upload vaccination records for easy access anywhere.</li>" if animal.vaccination_record.blank?
    notifications << "<ul>"
    return notifications.html_safe
  end
  
  def household_notification(notification)
    if notification.animal.present?
      notification.animal.name + ": " + notification.message
    else 
      notification.message
    end
  end
  
  def household_notification_url(notification)
    if notification.url.present?
      return notification.url
    elsif notification.animal.present?
      return [notification.animal.owner, notification.animal]
    else
      return nil
    end
  end
  
end
