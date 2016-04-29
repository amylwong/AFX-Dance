ActiveAdmin.register CastingGroup do
    
    permit_params :video
    
    before_create do |product|
        product.creator = adasdad
    end
    
    controller do
        def create
            casting_group = CastingGroup.create!(:video => params[:casting_group][:video])
            member_ids = params[:casting_group][:members].split(",")
            dancers = Dancer.where(id: member_ids)
            for dancer in dancers  
                dancer.casting_group = casting_group
                dancer.save
                member_ids.delete(dancer.id.to_s)
            end
            if member_ids.length != 0
                flash[:notice] = "The following dancers were not added to the casting group: " + member_ids.to_s
            end
            redirect_to("/admin/casting_groups/#{casting_group.id}")
        end
        
        def update
            casting_group = CastingGroup.find(params[:id])
            casting_group.video = params[:casting_group][:video]
            # this is to clear current dancers, lmao
            for dancer in casting_group.dancers
                dancer.casting_group = nil
                dancer.save
            end
            # save new dancers
            member_ids = params[:casting_group][:members].split(",")
            dancers = Dancer.where(id: member_ids)
            for dancer in dancers  
                dancer.casting_group = casting_group
                dancer.save
                member_ids.delete(dancer.id.to_s)
            end
            casting_group.save
            if member_ids.length != 0
                redirect_to "/admin/casting_groups/#{casting_group.id}", :alert => "The following dancers were not added to the casting group: " + member_ids.to_s
            else
                redirect_to "/admin/casting_groups/#{casting_group.id}"
            end
        end
    end
    
    
    index do
        selectable_column
        column :id
        column :dancers do |cg|
            cg.dancers.each.collect { |item| item.name }.join(", ") 
        end
        column :dancer_ids do |cg|
            cg.dancers.each.collect { |item| item.id }.join(", ")
        end
        column :video
        actions
    end
    
    
    show do |user|
        casting_group = CastingGroup.find(params[:id])
        panel "Details" do
            attributes_table_for user do
                row :dancers do
                    casting_group.dancers.each.collect { |item| item.name }.join(", ") 
                end
                row :dancer_ids do
                    casting_group.dancers.each.collect { |item| item.id }.join(", ")
                end
                row :casting_link do
                    text_node link_to(casting_group.video, casting_group.video, method: :get).html_safe
                end
                row :casting_video do |dancer|
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
    
    form do |f|
        
        f.inputs do
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
    
   
   config.per_page = 15 
end
