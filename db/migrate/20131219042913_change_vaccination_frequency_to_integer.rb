class ChangeVaccinationFrequencyToInteger < ActiveRecord::Migration
  def change
    remove_column :vaccinations, :frequency
    add_column :vaccinations, :frequency, :integer
  end
end
