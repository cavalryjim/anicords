class RenameAnimalImageToAvatar < ActiveRecord::Migration
  def change
    rename_column(:animals, :image, :avatar)
  end
end
