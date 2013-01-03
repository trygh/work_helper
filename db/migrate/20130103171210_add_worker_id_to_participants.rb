class AddWorkerIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :worker_id, :integer
  end
end
