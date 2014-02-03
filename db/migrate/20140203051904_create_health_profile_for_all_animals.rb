class CreateHealthProfileForAllAnimals < ActiveRecord::Migration
  def change
    Animal.all.each do |animal|
      animal.create_health_profile unless animal.health_profile.present?
    end
  end
end
