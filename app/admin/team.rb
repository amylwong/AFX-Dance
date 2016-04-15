ActiveAdmin.register Team do
    
    permit_params :project, :name, dancer_ids: []
    
    member_action :toggle_lock, :method => :post do
        current_team = Team.find(params[:id])
        if current_admin_user.team == current_team or current_admin_user.admin_type == "admin"
            if not current_team.has_conflicted_dancers
                current_team.toggle_lock
                current_team.save
                if current_team.locked
                    redirect_to "/admin/teams/#{params[:id]}", :alert => "#{current_team.name} has been locked"
                else
                    redirect_to "/admin/teams/#{params[:id]}", :alert => "#{current_team.name} has been unlocked"
                end
            else
                redirect_to "/admin/teams/#{params[:id]}", :alert => "Unable to lock #{current_team.name}. There are dancer conflicts"
            end
        else
            redirect_to "/admin/teams/#{params[:id]}", :alert => "You do not have ownership of #{current_team.name}"
        end
    end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

    show do |user|
        list = []
        Team.find(params[:id]).dancers.all.each do |dancer|
            list << dancer
        end
        
        panel "Details" do 
    
            attributes_table_for user do
                current_team = Team.find(params[:id])
                row :team_level do
                    if current_team.project
                        "Project Team"
                    else
                        "Training Team"
                    end
                end
                row :locked do
                    current_team.locked
                end
                row :toggle_lock do
                    link_to "Toggle Team Lock", "/admin/teams/#{params[:id]}/toggle_lock" , method: :post
                end
                row :team_size do
                    current_team.dancers.all.length
                end
            end
        end
        
        panel "Dancers" do 
            attributes_table_for user do
                list.each do |dancer|
                    row dancer.name do
                        link_to('See Profile', "/admin/dancers/#{dancer.id}")
                    end
                end
            end 
        end
        active_admin_comments
    end
    
    form do |f|
        f.inputs do
            f.input :project
            f.input :name
        end
    end
end
