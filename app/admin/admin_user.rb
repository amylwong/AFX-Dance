ActiveAdmin.register AdminUser do
  
  permit_params :email, :password, :password_confirmation, :admin_type

  index do
    selectable_column
    id_column
    column :email
    column :type
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :type
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :admin_type
      f.input :team
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  
  show do
    attributes_table *default_attribute_table_rows
    panel "Team" do
      table_for admin_user.team do
        column :name
        column :project
      end
    end
    active_admin_comments
  end

end
