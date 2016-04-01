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
end
