class AddMailingListToBetaComments < ActiveRecord::Migration
  def change
    add_column :beta_comments, :mailing_list, :boolean, default: true
  end
end
