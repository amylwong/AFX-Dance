class AddConflictedToDancer < ActiveRecord::Migration
  def change
    add_column :dancers, :conflicted, :boolean, default: false
  end
end
