module OrganizationsHelper
  
  def intake_reasons
    [
      'owner surrender',
      'pulled from animal control',
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
  
  def thumbnail(animal)
    animal.org_profile.thumbnail_url if animal.org_profile
  end
  
end
