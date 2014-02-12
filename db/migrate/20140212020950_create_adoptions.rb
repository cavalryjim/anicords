class CreateAdoptions < ActiveRecord::Migration
  def change
    create_table :adoptions do |t|
      t.integer     :organization_id
      t.integer     :animal_id
      t.integer     :organization_user_id
      t.date        :date
      t.string      :location
      t.text        :comments
      t.integer     :transferee_user_id
      t.string      :transferee_first_name 
      t.string      :transferee_last_name 
      t.string      :transferee_email
      t.string      :transferee_phone
      t.string      :transferee_address1
      t.string      :transferee_address2
      t.string      :transferee_city
      t.string      :transferee_state
      t.string      :transferee_zip
      t.timestamps
    end
  end
end
