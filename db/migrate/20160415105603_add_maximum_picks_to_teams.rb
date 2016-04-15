class AddMaximumPicksToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :maximum_picks, :integer
  end
end
