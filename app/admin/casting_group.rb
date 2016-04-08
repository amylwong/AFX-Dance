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
    end
    
    show do |user|
        casting_group = CastingGroup.find(params[:id])
        attributes_table *default_attribute_table_rows
        panel "Audition Video" do
            text_node link_to(casting_group.video, casting_group.video, method: :get).html_safe
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
        f.actions
    end
    
end
