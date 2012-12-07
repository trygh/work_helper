ActiveAdmin.register TaskReport do
  index do
    selectable_column
    column :title
    column :minutes
    column :project
    column :reported_for
    default_actions
  end

  show do |ad|
    attributes_table do
      row :user
      row :minutes
      row :reported_for
      row :content
    end
    active_admin_comments
  end
  # form do |f|
  #   f.input :title
  #   f.input :content
  #   f.input :url
  #   f.select :user_id
  #   f.select :project_id
  #   f.input :minutes
  # end
  # render :partial => "admin/task_report"
end
