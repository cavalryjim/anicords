module HouseholdsHelper
  def animal_image(animal)
    if animal.animal_type.short_name == 'dog'
      image_tag('golden-retriever.jpg', size: '50x50', class: 'th')
    elsif animal.animal_type.short_name == 'cat'
      image_tag('cat.jpg', size: '50x50', class: 'th')
    elsif animal.animal_type.short_name == 'horse'
      image_tag('horse.jpg', size: '50x50', class: 'th')
    else
      image_tag('doo_fav.png', class: 'th')
    end
  end
  
  def remove_provider_path_help(household_id, provider_id)
    association = HouseholdAssociation.where(household_id: household_id, service_provider_id: provider_id).first
    household_household_association_path(household_id, association.id)
  end
end
