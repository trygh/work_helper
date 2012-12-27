ActiveAdmin.register User do
  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :last_sign_in_at
    default_actions
  end

  show do |ad|
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :last_sign_in_at
    end
    panel "Task Reports" do
      table_for user.task_reports do
        column "title" do |report|
          link_to report.title, admin_task_report_path(report)
        end
        column "reported for" do |report|
          report.reported_for
        end
        column "project" do |report|
          link_to(report.project.name, admin_project_path(report.project))
        end
      end
    end
    active_admin_comments
  end

end
