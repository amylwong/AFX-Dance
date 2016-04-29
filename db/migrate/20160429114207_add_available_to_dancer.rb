class AddAvailableToDancer < ActiveRecord::Migration
  def change
    add_column :dancers, :available, :boolean, default: true
  end
end
