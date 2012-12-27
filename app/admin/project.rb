ActiveAdmin.register Project do
  index do
    selectable_column
    column :name
    column :created_at
    default_actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :url do |project|
        link_to project.url, project.url, target: "_blank"
      end
      row :created_at
      row :company
    end
    panel "Participants" do
      table_for project.participants do
        column "First Name" do |participant|
          span do
            link_to participant.user.first_name, admin_user_path(participant.user)
          end
          span do
            link_to participant.user.last_name, admin_user_path(participant.user)
          end
        end
        column "Email" do |participant|
          link_to participant.user.email, admin_user_path(participant.user)
        end
        column "Role" do |participant|
          Participant::ROLE_BY_ID[participant.role_id]
        end
      end
    end
    panel "Task Reports" do
      table_for project.task_reports do
        column "user" do |report|
          span do
            link_to(report.user.first_name, admin_user_path(report.user))
          end
          span do
            link_to(report.user.last_name, admin_user_path(report.user))
          end
        end
        column "title" do |report|
          link_to(report.title, admin_task_report_path(report))
        end
        column "minutes" do |report|
          report.minutes
        end
        column "reported for" do |report|
          l report.reported_for, format: :long
        end
        column "project" do |report|
          link_to(report.project.name, admin_project_path(report.project))
        end
      end
    end
    active_admin_comments
  end
end
