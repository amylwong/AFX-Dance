class UpdateAdminUserFields < ActiveRecord::Migration
  def change
    add_column :admin_users, :admin_type, :string
    add_column :admin_users, :team_id, :integer
  end
end
