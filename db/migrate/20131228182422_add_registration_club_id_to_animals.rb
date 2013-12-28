class AddRegistrationClubIdToAnimals < ActiveRecord::Migration
  def change
    add_column :animals, :registration_club_id, :integer
  end
end
