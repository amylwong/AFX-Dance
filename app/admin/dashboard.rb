ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome to the AFX Audition Site!!"
        small "See below for more information"
        small "NOTE: We have a weird bug with the formatting so if the site looks funny just refresh it."
      end
    end

    columns do
      column do
        panel "Navigation" do
          ul do
            li link_to("How do I use this site?", "/info")
            li link_to("Home Page","/")
            li link_to("Signup Form","/auditionform")
          end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
