ActiveAdmin.register Company do
  show do |ad|
    attributes_table do
      row :name
      row :created_at
    end
    panel "Projects" do
      table_for company.projects do
        column "Project Name" do |project|
           link_to project.name, admin_project_path(project)
        end
        column "created_at" do |project|
           l project.created_at, format: :long
         end
        column "Participants count" do |project|
           project.participants.count
        end
      end
    end

    panel "Workers in company" do
      table_for company.workers do
        column "Full Name" do |worker|
          span do
            link_to (worker.user.first_name + "  " + worker.user.last_name), admin_user_path(worker.user)
          end
        end
        column "Email" do |worker|
          link_to worker.user.email, admin_user_path(worker.user)
        end
        column "Hourly Rate" do |worker|
          number_to_currency worker.hourly_rate
        end
      end
    end
  end
end
