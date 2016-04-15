class AddNamesToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :names, :string
  end
end
