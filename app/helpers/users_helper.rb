module UsersHelper
  
  def image(association)
    case association.type
    when 'household'
      image_tag('black-white-house-md.png', size: '15x15')
    when 'breeder'
      image_tag('a-variety-of-black-and-white-dog-dog-vector-material_15-1891.jpg', size: '15x15')
    when 'veterinarian'
      image_tag('stock-illustration-10774918-dog-veterinarian.jpg', size: '15x15')
    when 'organization'
      image_tag('black-white-house-md.png', size: '15x15')
    else
      image_tag('black-white-house-md.png', size: '15x15')
    end
  end
  
end
