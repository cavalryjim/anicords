module OrganizationsHelper
  
  def intake_reasons
    [
      'owner surrender',
      'pulled from animal control',
      'stray',
      'returned',
      'other'
    ]
  end
  
  def location(animal)
    if animal.org_profile.organization_location.present?
      animal.org_profile.organization_location.name
    else
      animal.owner
    end
  end
  
  def symbolize_id(owner)
    (owner.class.name.downcase << '_id').to_sym
  end
  
  def org_notification(notification)
    if notification.animal.present?
      notification.animal.name + ": " + notification.message
    else 
      notification.message
    end
  end
  
  def organization_roles
    [['member (limited access)', :org_member],
    ['administrator (dogs only)', :admin_dogs], 
    ['administrator (cats only)', :admin_cats],
    ['administrator (vaccinations)', :admin_vaccinations],
    ['administrator (full access)', :admin],
    ['vet services', :org_vet]]
  end
  
end
