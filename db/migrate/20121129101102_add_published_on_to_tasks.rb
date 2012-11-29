class AddPublishedOnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :published_on, :date
  end
end
