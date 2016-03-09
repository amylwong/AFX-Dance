class Initial < ActiveRecord::Migration
  
  #many-to-many relationship between dancers -> teams
  #one-to-many relationship between casting_group -> dancers
  
  def up
    create_table :dancers do |t|
      t.belongs_to :casting_group, index: true
      t.string :name
      t.integer :audition
      t.string :email
      t.string :phone
      t.string :year
      t.string :gender
    end
    
    create_table :teams do |t|
      t.boolean :project
      t.string :name
    end
    
    create_table :casting_groups do |t|
      t.integer :number
      t.string :video
    end
    
    create_table :dancers_teams, id: false do |t|
      t.belongs_to :team, index: true
      t.belongs_to :dancer, index: true
    end
  end
  
end
