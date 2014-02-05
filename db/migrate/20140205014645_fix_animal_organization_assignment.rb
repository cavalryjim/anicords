class FixAnimalOrganizationAssignment < ActiveRecord::Migration
  def change
    Animal.all.each do |animal|
      animal.update_attribute :organization_id, animal.owner_id if animal.owner.class.name == "Organization"
    end
  end
end
