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
                if current_admin_user.team.can_add(ids.length)
                    added = current_admin_user.team.add_dancers(ids)
                    redirect_to '/admin/dancers', :alert => "#{added} added to your team"
                else
                    redirect_to '/admin/dancers', :alert => "You are over the maximum number of picks you can have"
                end
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
    
    index do
        selectable_column
        column :id
        column :name
        column :team_offers do |dancer|
            dancer.teams.each.collect { |item| item.name }.join(", ")
        end
        column :casting_video do |dancer|
            text_node link_to(dancer.casting_group.video, dancer.casting_group.video, method: :get).html_safe
        end
        column :casting_group
        column :conflicted
        actions do |dancer|
            link_to "Add to my Team" #Do the thing here yay
        end
    end
    
    show do |dancer|
        panel "Details" do 
            attributes_table_for dancer do
              row :id
              row :name
              row :email
              row :phone
              row :year
              row :gender
            end
        end
        
        panel "Teams" do
            attributes_table_for dancer do
                row :conflicted
                row :team_offers do
                      Dancer.find(params[:id]).teams.collect(&:name).join(", ")
                end
            end
        end
        
        panel "Casting" do
            attributes_table_for dancer do
                row :casting_group
                row :casting_link do |dancer|
                    text_node link_to(dancer.casting_group.video, dancer.casting_group.video, method: :get).html_safe
                end
                row :casting_video do |dancer|
                    regex = /^(?:https?:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
                    parse = dancer.casting_group.video.match(regex)
                    parse_link = 'Embed Failed'
                    if parse
                      parse_link = parse[1]
                      text_node %{<iframe src="https://www.youtube.com/embed/#{parse_link}" width="640" height="480" scrolling="no" frameborder="no"></iframe>}.html_safe
                    end
                end
            end
        end
    
    active_admin_comments
  end
    
    
    csv do
        column(:casting_number) { |dancer| dancer.id }
        column(:name) { |dancer| dancer.name }
        column(:email) { |dancer| dancer.email }
        column(:phone) { |dancer| dancer.phone }
        column(:year) { |dancer| dancer.year }
        column(:gender) { |dancer| dancer.gender }
        column(:teams) { |dancer| dancer.teams.each.collect { |item| item.name }.join(", ") }
    end
    
end
