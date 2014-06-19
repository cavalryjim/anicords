class AddActiveToAnimals < ActiveRecord::Migration
  #JDavis: need to rollback, add these changes, and migrate again.  JDhere.
  # add_column :animals, :active, :boolean, default: true
  # Animal.update_all(active: true)
  
  def change
    add_column :animals, :active, :boolean
  end
end
