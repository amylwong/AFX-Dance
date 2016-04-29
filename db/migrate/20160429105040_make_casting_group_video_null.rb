class MakeCastingGroupVideoNull < ActiveRecord::Migration
  def change
    change_column :casting_groups, :video, :string, :null => true
  end
end
