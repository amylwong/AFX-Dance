ActiveAdmin.register CastingGroup do
    
    permit_params :video
    
    controller do

        def create # called when creating a new CastingGroup
            # validate CastingGroup information being passed in
            casting_group = CastingGroup.create(:video => params[:casting_group][:video])
            if casting_group.errors.any?
                flash[:notice] = "The video field must contain a valid url"
                redirect_to("/admin/casting_groups/new")
                return
            end
            
            # retrieve a list of dancer ids that we will update
            dancers_to_update = Dancer.where(id: member_ids).pluck(:id)
            
            # find extraneous ids that don't correspond to Dancer pks
            dancers_not_updated = member_ids - dancers_to_update
            
            # update only the dancer ids that were found
            Dancer.where(id: dancers_to_update).update_all(casting_group: casting_group.id)
            
            # raise alert if any included dancer ids were not updated
            if dancers_not_updated.length != 0
                flash[:notice] = "The following dancers were not added to the casting group: " + dancers_not_updated.to_s
            end

            redirect_to("/admin/casting_groups/#{casting_group.id}")
        end
        
        def update # called when updating an existing CastingGroup
            # inside `update`, we update video as well as a list of dancers
            # note that the intended behavior is to "overwrite" the previous list of dancers
            # essentially, this means that we have to clear previous dancers, THEN set the new ones

            # get the casting group to update
            casting_group = CastingGroup.find(params[:id])
            # update the video
            casting_group.video = params[:casting_group][:video]
            casting_group.save
            
            # clear old dancers
            Dancer.where(id: casting_group.dancers.pluck(:id)).update_all(casting_group: nil)
            
            # get dancers to update and find extraneous ids that don't correspond to Dancer pks
            member_ids = params[:casting_group][:members].split(",")
            dancers_to_update = Dancer.where(id: member_ids).pluck(:id)
            dancers_not_updated = member_ids - dancers_to_update
            
            # save new dancers
            Dancer.where(id: dancers_to_update).update_all(casting_group: casting_group.id)
            
            # raise alert if any included dancer ids were not updated
            if dancers_not_updated.length != 0
                redirect_to "/admin/casting_groups/#{casting_group.id}", :alert => "The following dancers were not added to the casting group: " + dancers_not_updated.to_s
            else
                redirect_to "/admin/casting_groups/#{casting_group.id}"
            end
        end
    end
    
    index do # called when displaying a list of CastingGroups
        selectable_column
        # display the CastingGroup's id
        column :id
        column :dancers do |cg|
            # display a comma-separated list of dancer names
            cg.dancers.each.collect { |item| item.name }.join(", ") 
        end
        column :dancer_ids do |cg|
            # display a comma-separated list of dancer ids
            cg.dancers.each.collect { |item| item.id }.join(", ")
        end
        # display the video
        column :video
        actions
    end
    
    show do |user| # called when displaying a specific CastingGroup
        casting_group = CastingGroup.find(params[:id])
        panel "Details" do
            attributes_table_for user do
                row :dancers do
                    # display a comma-separated list of user names
                    casting_group.dancers.each.collect { |item| item.name }.join(", ") 
                end
                row :dancer_ids do
                    # display a comma-separated list of user ids
                    casting_group.dancers.each.collect { |item| item.id }.join(", ")
                end
                row :casting_link do
                    # display the casting link
                    text_node link_to(casting_group.video, casting_group.video, method: :get).html_safe
                end
                row :casting_video do |dancer|
                    # display the youtube video with special parsing to embed the youtube video
                    regex = /^(?:https?:\/\/)?(?:www\.)?\w*\.\w*\/(?:watch\?v=)?((?:p\/)?[\w\-]+)/
                    parse = casting_group.video.match(regex)
                    parse_link = 'Embed Failed'
                    if parse
                      parse_link = parse[1]
                      text_node %{<iframe src="https://www.youtube.com/embed/#{parse_link}" width="640" height="480" scrolling="no" frameborder="no"></iframe>}.html_safe
                    end
                end
            end
        end
        panel "Dancers" do 
            attributes_table_for user do
                casting_group.dancers.each do |dancer|
                    row dancer.name do
                        link_to('See Profile', "/admin/dancers/#{dancer.id}")
                    end
                end
            end 
        end
        active_admin_comments
    end
    
    form do |f| # form to create / update a CastingGroup
        f.inputs do # we allow the user to input video + a comma separated string of member ids
            f.input :video
            f.input :members
        end
        
        if params[:id] != nil
            casting_group = CastingGroup.find(params[:id])
            member_ids = ""
            for dancer in casting_group.dancers
                member_ids += dancer.id.to_s + ","
            end
            if member_ids[-1,1] == ","
                member_ids = member_ids.chomp(",")
            end
            if member_ids == ""
                member_ids = "No dancers to display"
            end
            
            start_format = "<ol><li class=\"string input optional stringish\">"
            end_format = "</li></ol>"
            
            f.inputs "Current Dancer IDs" do
                (start_format + member_ids + end_format).html_safe
            end
        end
        f.actions
    end
    
    csv do
        column(:casting_group) { |casting_group| casting_group.id }
        column(:dancers) { |casting_group| casting_group.dancers.each.collect { |item| item.name }.join(", ") }
        column(:dancers_ids) { |casting_group| casting_group.dancers.each.collect { |item| item.id }.join(", ") }
        column(:video) { |casting_group| casting_group.video}
    end
   
    filter :id, label: 'Casting Group Number'
    
    config.per_page = 15 # show 15 results per page
 
end
