class CreateTaskReports < ActiveRecord::Migration
  def change
    create_table :task_reports do |t|
      t.string :title
      t.text :content
      t.string :url
      t.integer :user_id
      t.integer :project_id
      t.integer :minutes

      t.timestamps
    end
  end
end
