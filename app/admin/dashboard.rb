ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span "Welcome to Active Admin. This is the default dashboard page."
    #     small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.

    # columns do
    #   column do
    #     panel "Latest Projects" do
    #       ul do
    #         # Project.recent(5).map do |post|
    #         Project.order("created_at desc").limit(5).map do |project|
    #           li link_to(project.name, admin_project_path(project))
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

    div :class => "panel", :id => "dashboard_default_message" do
      panel "Latest Task Reports" do
        table_for TaskReport.order("reported_for desc").limit(5) do
          column :title
          column :user
          column :project
          column :reported_for
        end
        strong { link_to "View All Task Reports", admin_task_reports_path }
      end
    end

    div :class => "panel", :id => "dashboard_default_message" do
      panel "Latest Projects" do
        table_for Project.order("created_at desc").limit(5) do
          column :name
          column :created_at
        end
        strong { link_to "View All Projects", admin_projects_path }
      end
    end

    div :class => "panel", :id => "dashboard_default_message" do
      panel "Latest Users" do
        table_for User.order("created_at desc").limit(5) do
          column :email
          column :last_name
          column :first_name
          column :created_at
        end
        strong { link_to "View All Users", admin_users_path }
      end
    end

  end # content
  sidebar :sidebar do
    ul do
      li "Some menu"
    end
  end
end
