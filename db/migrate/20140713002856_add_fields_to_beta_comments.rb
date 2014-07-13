class AddFieldsToBetaComments < ActiveRecord::Migration
  def change
    add_column :beta_comments, :name, :string
    add_column :beta_comments, :email, :string
  end
end
