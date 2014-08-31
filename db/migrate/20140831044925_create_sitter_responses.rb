class CreateSitterResponses < ActiveRecord::Migration
  def change
    create_table :sitter_responses do |t|
      t.integer     :sitter_request_id
      t.integer     :user_id
      t.string      :response
      t.timestamps
    end
  end
end
