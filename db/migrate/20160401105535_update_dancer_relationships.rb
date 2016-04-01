class UpdateDancerRelationships < ActiveRecord::Migration
  def change
    remove_column :dancers, :audition, :integer
    remove_column :casting_groups, :number, :integer
  end
end
