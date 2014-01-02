module HouseholdsHelper
  def animal_image(animal)
    case animal.species
    when 'dog'
      image_tag('dog_icon.png', size: '50x50', id: 'animal'+animal.id.to_s, class: image_classes(animal) )
    when 'cat'
      image_tag('cat_icon.png', size: '50x50', id: 'animal'+animal.id.to_s, class: image_classes(animal))
    when 'horse'
      image_tag('horse_icon.png', size: '50x50', id: 'animal'+animal.id.to_s, class: image_classes(animal))
    when'tiger'
      image_tag('tiger_icon.png', size: '50x50', id: 'animal'+animal.id.to_s, class: image_classes(animal))
    else
      image_tag('generic_icon.png', size: '50x50', id: 'animal'+animal.id.to_s, class: image_classes(animal))
    end
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
  
  def image_classes(animal)
    if animal.pending_transfer? 
      classes = 'transfer_image' 
    else
      classes = 'th'
    end
    classes << ' animal_alert' if (animal.profile_completion < 50)
    return classes
  end
  
  def animal_notifications(animal)
    notifications = "<ul class='notifications'>"
    notifications << "<li>Schedule appointments by adding service providers.</li>" if animal.service_providers.count == 0
    notifications << "<li>Order food and supplies by updating the preferences tab.</li>" if true
    notifications << "<li>Recieve alerts regarding heartworm meds or vaccinations by updating the health & wellness tab.</li>" if true
    notifications << "<ul>"
    return notifications.html_safe
  end
end
