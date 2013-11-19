module HouseholdsHelper
  def animal_image(animal)
    case animal.species
    when 'dog'
      image_tag('dog_icon.png', size: '50x50', class: 'th')
    when 'cat'
      image_tag('cat_icon.png', size: '50x50', class: 'th')
    when 'horse'
      image_tag('horse_icon.png', size: '50x50', class: 'th')
    when'tiger'
      image_tag('tiger_icon.png', size: '50x50', class: 'th')
    else
      image_tag('generic_icon.png', size: '50x50', class: 'th')
    end
  end
  
  def remove_provider_path_help(household_id, provider_id)
    association = HouseholdAssociation.where(household_id: household_id, service_provider_id: provider_id).first
    household_household_association_path(household_id, association.id)
  end
end
