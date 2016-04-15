class AddLockedToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :locked, :boolean, default: false
  end
end
