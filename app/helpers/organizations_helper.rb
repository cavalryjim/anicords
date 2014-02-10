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
    if animal.avatar.present?
      animal.avatar.url
    elsif animal.org_profile && animal.org_profile.thumbnail_url.present?
      animal.org_profile.thumbnail_url  
    else 
      s3_url('doo_fav.png')  
    end
  end
  
  def symbolize_id(owner)
    (owner.class.name.downcase << '_id').to_sym
  end
  
end
