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
  
  def location_options(organization)
    organization.organization_locations.map{|l| [ l.id, l.name ]}
    #[[1, "Davis Household"], [2, "pet rescue"]]
  end
  
  def thumbnail(animal)
    (animal.org_profile && animal.org_profile.thumbnail_url.present?) ? animal.org_profile.thumbnail_url  : s3_url('doo_fav.png')
  end
  
  def symbolize_id(owner)
    (owner.class.name.downcase << '_id').to_sym
  end
  
end
