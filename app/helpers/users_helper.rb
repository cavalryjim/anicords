module UsersHelper
  
  def image(association)
    case association.group_type
    when 'Household'
      image_tag(s3_url('black-white-house-md.png'), size: '50x50')
    when 'Breeder'
      image_tag(s3_url('animalminder.ico'), size: '50x50')
    when 'ServiceProvider'
      image_tag(s3_url('provider_icon.png'), size: '50x50')
    when 'Organization'
      image_tag(s3_url('barn-icon.png'), size: '50x50')
    else
      image_tag(s3_url('animalminder.ico'), size: '50x50')
    end
  end

  
end
