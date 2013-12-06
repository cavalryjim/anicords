class UpdateUserPolymorphicGrouping < ActiveRecord::Migration
  def self.up
    UserAssociation.find(:all).each do |ua|
      if ua.household_id
        ua.update_attribute :group_id, ua.household_id
        ua.update_attribute :group_type, "Household"
      elsif ua.service_provider_id
        ua.update_attribute :group_id, ua.service_provider_id
        ua.update_attribute :group_type, "ServiceProvider"
      elsif ua.breeder_id
        ua.update_attribute :group_id, ua.breeder_id
        ua.update_attribute :group_type, "Breeder"
      end
    end
  end
end
