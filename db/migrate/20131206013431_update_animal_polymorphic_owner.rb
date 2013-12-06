class UpdateAnimalPolymorphicOwner < ActiveRecord::Migration
  def self.up
    Animal.find(:all).each do |a|
      if a.household_id
        a.update_attribute :owner_id, a.household_id
        a.update_attribute :owner_type, "Household"
      elsif a.breeder_id
        a.update_attribute :owner_id, a.breeder_id
        a.update_attribute :owner_type, "Breeder"
      end
    end
  end
end
