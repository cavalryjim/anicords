class ChangeIntakeReasonToString < ActiveRecord::Migration
  def change
    change_column :org_profiles, :intake_reason, :string
  end
end
