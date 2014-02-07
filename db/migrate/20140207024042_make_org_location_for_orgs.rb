class MakeOrgLocationForOrgs < ActiveRecord::Migration
  def change
    Organization.all.each do |org|
      org.make_organization_location unless org.organization_locations.present?
    end
    
    Animal.all.each do |animal|
     if animal.owner == animal.organization
      animal.create_org_profile unless animal.org_profile.present? 
      unless animal.org_profile.organization_location_id.present?
        animal.org_profile.organization_location_id = animal.organization.organization_locations.first.id 
        animal.save
      end
     end
    end
    
  end
end
