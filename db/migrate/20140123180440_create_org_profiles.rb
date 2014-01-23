class CreateOrgProfiles < ActiveRecord::Migration
  def change
    drop_table :animal_org_profiles if self.table_exists?("animal_org_profiles")
    
    create_table :org_profiles do |t|
      t.integer     :animal_id
      t.date        :intake_date
      t.integer     :intake_reason
      t.string      :location
      t.integer     :foster_household_id
      t.references  :neuter_location, polymorphic: true
      t.float       :intake_weight
      t.string      :intake_weight_measure
      t.timestamps
    end
  end
end
