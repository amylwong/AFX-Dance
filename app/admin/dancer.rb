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
    
    member_action :add_to_my_team, :method => :post do
        ids = params[:id]
        add_helper(ids, current_admin_user)
    end
    
    member_action :remove_from_my_team, :method => :post do
        ids = params[:id]
        remove_helper(ids, current_admin_user)
    end
    
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
    
    controller do
        
        def add_helper(ids, current_admin_user)
            nil_casting_group = []
            Dancer.find(Array(ids)).each do |id|
                if id.casting_group == nil
                    nil_casting_group << id.name
                end
            end
            
            if current_admin_user.team == nil
                redirect_to '/admin/dancers', :alert => "your account is not associated with a team"
            elsif nil_casting_group.length > 0
                redirect_to '/admin/dancers', :alert => "#{nil_casting_group} is not in a casting group. All dancers must be in a casting group to be added. Please reselect."
            else
                if current_admin_user.team.locked
                    redirect_to '/admin/dancers', :alert => "#{current_admin_user.team.name} is currently locked right now"
                elsif current_admin_user.team.can_pick
                    if current_admin_user.team.can_add(ids.length)
                        added = current_admin_user.team.add_dancers(ids)
                        redirect_to '/admin/dancers', :alert => "#{added} added to #{current_admin_user.team.name}"
                    else
                        redirect_to '/admin/dancers', :alert => "You are over the maximum number of picks you can have"
                    end
                else
                    redirect_to '/admin/dancers', :alert => "You cannot pick right now, project teams are still picking"
                end
            end
        end
        
        
        def remove_helper(ids, current_admin_user)
            if current_admin_user.team == nil
                redirect_to '/admin/dancers', :alert => "your account is not associated with a team"
            else
                if current_admin_user.team.locked
                    redirect_to '/admin/dancers', :alert => "#{current_admin_user.team.name} is currently locked right now"
                elsif current_admin_user.team.can_pick
                    removed = current_admin_user.team.remove_dancers(ids)
                    redirect_to '/admin/dancers', :alert => "#{removed} have been deleted from #{current_admin_user.team.name}"
                else
                    redirect_to '/admin/dancers', :alert => "You cannot pick right now, project teams are still picking"
                end
            end
        end
    end
        
        

    batch_action :add_to_my_team do |ids|
        add_helper(ids, current_admin_user)
    end
    
    batch_action :remove_from_my_team do |ids|
        remove_helper(ids, current_admin_user)
    end
    
    batch_action :final_randomization do |ids|
        if Team.all_teams_done
            Team.final_randomization
        end
        redirect_to '/admin/dancers'
    end
    
    index do
        selectable_column
        column :id
        column :name
        column :team_offers do |dancer|
            dancer.teams.each.collect { |item| item.name }.join(", ")
        end
        column :casting_video do |dancer|
            if dancer.casting_group != nil
                text_node link_to(dancer.casting_group.video, dancer.casting_group.video, method: :get).html_safe
            end
        end
        column :casting_group
        column :conflicted
        column :add_to_my_team do |dancer|
            link_to "Add", "/admin/dancers/#{dancer.id}/add_to_my_team" , method: :post
        end
        column :remove_from_my_team do |dancer|
            link_to "Remove", "/admin/dancers/#{dancer.id}/remove_from_my_team" , method: :post
        end
        actions
        
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
                    if dancer.casting_group != nil
                        text_node link_to(dancer.casting_group.video, dancer.casting_group.video, method: :get).html_safe
                    end
                end
                row :casting_video do |dancer|
                    parse = nil
                    if dancer.casting_group != nil
                        regex = /^(?:https?:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
                        parse = dancer.casting_group.video.match(regex)
                    end
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
    
    #scope("Available"){|scope| scope.where(available:true)}
    scope :all, default: true
    scope("Conflicted"){|scope| scope.where(conflicted:true)}
    
    filter :conflicted, as: :check_boxes
    filter :name
    filter :id
    filter :teams
    
    config.per_page = 15
end
