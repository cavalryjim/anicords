class AddAdoptionFieldsToOrgProfile < ActiveRecord::Migration
  def change
    add_column :org_profiles, :adoption_date, :date
    add_column :org_profiles, :transferee_first_name, :string
    add_column :org_profiles, :transferee_last_name, :string
    add_column :org_profiles, :transferee_phone, :string
    add_column :org_profiles, :transferee_city, :string
    add_column :org_profiles, :transferee_state, :string
    add_column :org_profiles, :transferee_zip, :string
  end
end
