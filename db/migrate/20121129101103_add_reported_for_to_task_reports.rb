class AddReportedForToTaskReports < ActiveRecord::Migration
  def change
    add_column :task_reports, :reported_for, :date, null: false
  end
end
