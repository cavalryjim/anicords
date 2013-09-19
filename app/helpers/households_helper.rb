module HouseholdsHelper
  def animal_image(animal)
    image_tag('golden-retriever.jpg', size: '50x50')
  end
  
  def delete_path_help(household_id, provider_id)
    association = HouseholdAssociation.where(household_id: household_id, service_provider_id: provider_id).first
    household_household_association_path(household_id, association.id)
  end
end
