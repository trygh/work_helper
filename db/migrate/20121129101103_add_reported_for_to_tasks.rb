class AddReportedForToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :reported_for, :date, null: false
  end
end
