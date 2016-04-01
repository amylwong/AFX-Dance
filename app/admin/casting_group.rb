ActiveAdmin.register CastingGroup do
    
    permit_params :video
    
    show do
        
        casting_group = CastingGroup.find(params[:id])
        
        attributes_table *default_attribute_table_rows
        
        panel "Audition Video" do
            text_node link_to(casting_group.video, casting_group.video, method: :get).html_safe
        end
        
        active_admin_comments
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


end
