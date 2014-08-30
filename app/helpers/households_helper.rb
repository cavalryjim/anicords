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
    #notifications << "<li>Upload vaccination records for easy access anywhere.</li>" if animal.vaccination_record.blank?
    notifications << "<ul>"
    return notifications.html_safe
  end
  
  def additional_notifications(household)
    #household_notifications = household.notifications
    notes = ""
    household.animals.each do |animal|
      notes << "<li>" + notification_image_link(household, animal) + " Schedule appointments for " + notification_name_link(household, animal) + " by adding service providers.</li>" if animal.service_providers.count == 0
      notes << "<li>" + notification_image_link(household, animal) + " Recieve health alerts for " + notification_name_link(household, animal) + "  by updating the health & wellness tab.</li>" if animal.needs_vaccination_info?
      notes << "<li>" + notification_image_link(household, animal) + " Update feeding preferences for " + notification_name_link(household, animal) + " to easily send instructions to your kennel or sitter.</li>" if animal.needs_diet_info?
      notes << "<li>" + notification_image_link(household, animal) + " Upload vaccination records for " + notification_name_link(household, animal) + " easy access anywhere.</li>" if animal.vaccination_documents.blank?
    end
    return notes.html_safe
  end
  
  def notification_image_link(household, animal)
    link_to(thumbnail(animal, '50x50', 'th_only'), edit_household_animal_path(household, animal))
  end
  
  def notification_name_link(household, animal)
    link_to(animal.name, edit_household_animal_path(household, animal))
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
      return polymorphic_path([:edit, notification.animal.owner, notification.animal])
    else
      return nil
    end
  end
  
  def household_roles
    [['member (full access)', :member], 
    ['member (limited access)', :limited_member], 
    ['sitter (care instructions only)', :sitter]]
  end
  
end
