class RemovePublishedOnFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :published_on
  end
end
