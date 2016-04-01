class AddAdminUserToTeams < ActiveRecord::Migration
  def change
    add_reference :teams, :adminUser, index: true, foreign_key: true
  end
end
