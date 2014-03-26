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
      s3_url('petabyt_icon.png')  
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
  
end
