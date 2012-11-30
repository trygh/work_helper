class AddReportedForToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :reported_for, :date
  end
end
