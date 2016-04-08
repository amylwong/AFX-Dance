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
            puts "wow this is true"
            redirect_to '/admin/dancers', :alert => "your account is not associated with a team"
        else
            currTeam = current_admin_user.team
            list = []
            add = false
            Dancer.find(ids).each do |id|
                if not id.teams.include? currTeam
                    id.teams << currTeam
                    id.save
                    add = true
                end
                list << id.name
            end
            if add
                redirect_to '/admin/dancers', :alert => "#{list} added to your team"
            else
                redirect_to '/admin/dancers', :alert => "#{list} are already on your team"
            end 
        end
    end
    
    batch_action :remove_from_my_team do |ids|
        if current_admin_user.team == nil
            redirect_to '/admin/dancers', :alert => "your account is not associated with a team"
        else
            currTeam = current_admin_user.team
            list = []
            delete = false
            Dancer.find(ids).each do |id|
                if id.teams.include? currTeam
                    currTeam.dancers.delete(id)
                    currTeam.save
                    delete = true
                    list << id.name
                end
            end
            if delete
                redirect_to '/admin/dancers', :alert => "#{list} have been deleted from your team"
            else
                redirect_to '/admin/dancers', :alert => "#{list} were not on your team to start with"
            end 
        end
    end
end
