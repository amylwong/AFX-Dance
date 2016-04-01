ActiveAdmin.register Dancer do
    
    permit_params :name, :email, :phone, :year, :gender, team_ids: [], casting_group_ids: []
    
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

    batch_action :add_to_my_team do |ids|
        #Dancer.find(ids).each do |dancer|
            #flash[:notice] = "Hi #{dancer}"
            # team = Team.find_by name: 'Hi'
            # team.Dancers << dancer
        #end
        list = []
        add = false
        Dancer.find(ids).each do |id|
        #    flash[:notice] = "Hi #{id}"
            if not id.teams.include? Team.find(1)
                id.teams << Team.find(1)
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
    
    batch_action :remove_from_my_team do |ids|
        #Dancer.find(ids).each do |dancer|
            #flash[:notice] = "Hi #{dancer}"
            # team = Team.find_by name: 'Hi'
            # team.Dancers << dancer
        #end
        list = []
        delete = false
        Dancer.find(ids).each do |id|
            if id.teams.include? Team.find(1)
                Team.find(1).dancers.delete(id)
                Team.find(1).save
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
