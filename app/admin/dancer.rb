ActiveAdmin.register Dancer do
    
    permit_params :name, :email, :phone, :year, :gender, :casting_group_id, team_ids: [], casting_group_ids: []
    
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
    
    form do |f|
        f.inputs do
            f.input :casting_group, member_label: Proc.new { |c| "#{c.id}" }
            f.input :name
            f.input :email
            f.input :phone
            f.input :year
            f.input :gender
        end
        f.actions
    end

    batch_action :add_to_my_team do |ids|
        if current_admin_user.team == nil
            redirect_to '/admin/dancers', :alert => "your account is not associated with a team"
        else
            if current_admin_user.team.locked
                redirect_to '/admin/dancers', :alert => "Your team is currently locked right now"
            elsif current_admin_user.team.can_pick
                added = current_admin_user.team.add_dancers(ids)
                redirect_to '/admin/dancers', :alert => "#{added} added to your team"
            else
                redirect_to '/admin/dancers', :alert => "You cannot pick right now, project teams are still picking"
            end
        end
    end
    
    batch_action :remove_from_my_team do |ids|
        if current_admin_user.team == nil
            redirect_to '/admin/dancers', :alert => "your account is not associated with a team"
        else
            if current_admin_user.team.locked
                redirect_to '/admin/dancers', :alert => "Your team is currently locked right now"
            elsif current_admin_user.team.can_pick
                removed = current_admin_user.team.remove_dancers(ids)
                redirect_to '/admin/dancers', :alert => "#{removed} have been deleted from your team"
            else
                redirect_to '/admin/dancers', :alert => "You cannot pick right now, project teams are still picking"
            end
        end
    end
end
