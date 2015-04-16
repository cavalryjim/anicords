class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string    :name
      t.string    :subdomain
      t.string    :address1
      t.string    :address2
      t.string    :city
      t.string    :parish
      t.string    :state
      t.string    :zip
      t.string    :website
      t.string    :logo_url
      t.timestamps
    end
  end
end
