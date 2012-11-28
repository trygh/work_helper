ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     # span "Welcome to Active Admin. This is the default dashboard page."
    #     # small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "All Projects" do
          ul do
            # Project.recent(5).map do |post|
            Project.all.map do |project|
              li link_to(project.name, admin_project_path(project))
            end
          end
        end
      end

      # column do
      #   panel "Info" do
      #     para "Welcome to ActiveAdmin."
      #   end
      # end
    end
  end # content
end
