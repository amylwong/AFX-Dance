ActiveAdmin.register Team do
    
    permit_params :project, :name, dancer_ids: []

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
                row :team_level do
                    if Team.find(params[:id]).project
                        "Project Team"
                    else
                        "Training Team"
                    end
                end
                row :team_size do
                    Team.find(params[:id]).dancers.all.length
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
    
    csv do
        column(:team) { |team| team.name }
        column(:dancers) { |team| team.dancers.collect(&:name).join(", ") }
    end
end