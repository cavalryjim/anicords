module UsersHelper
  
  def image(association)
    case association.type
    when 'household'
      image_tag(s3_url('black-white-house-md.png'), size: '15x15')
    when 'breeder'
      image_tag(s3_url('petabyt_icon.png'), size: '15x15')
    when 'veterinarian'
      image_tag(s3_url('petabyt_icon.png'), size: '15x15')
    when 'organization'
      image_tag(s3_url('barn-icon.png'), size: '15x15')
    else
      image_tag(s3_url('petabyt_icon.png'), size: '15x15')
    end
  end

  
end
