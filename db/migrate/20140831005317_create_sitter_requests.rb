class CreateSitterRequests < ActiveRecord::Migration
  def change
    create_table :sitter_requests do |t|
      t.integer     :household_id
      t.datetime    :start_datetime
      t.datetime    :end_datetime
      t.text        :comments
      t.integer     :confirmed_sitter_id

      t.timestamps
    end
  end
end
