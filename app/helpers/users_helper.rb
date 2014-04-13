module UsersHelper
  
  def image(association)
    case association.group_type
    when 'Household'
      image_tag(s3_url('black-white-house-md.png'), size: '15x15')
    when 'Breeder'
      image_tag(s3_url('petabyt_icon.png'), size: '15x15')
    when 'ServiceProvider'
      image_tag(s3_url('provider_icon.png'), size: '15x15')
    when 'Organization'
      image_tag(s3_url('barn-icon.png'), size: '15x15')
    else
      image_tag(s3_url('petabyt_icon.png'), size: '15x15')
    end
  end

  
end
