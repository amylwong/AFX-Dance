ActiveAdmin.register AdminUser do
  
  permit_params :email, :password, :password_confirmation, :admin_type, :team, :team_id

  index do
    selectable_column
    id_column
    column :email
    column :admin_type
    column :names
    column :teams
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :names
      f.input :admin_type
      f.input :team
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  
  show do
    panel "Details" do 
      attributes_table_for admin_user do
        row :admin_type
        row :names
      end
    end
    
    panel "Team" do
      attributes_table_for admin_user.team do
        row :name
        row :project
      end
    end
    active_admin_comments
  end
  
  filter :admin_type
  filter :names
  
  config.per_page = 15

end
