class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :user_id, null: false
      t.integer :project_id, null: false
      t.integer :role_id, null: false
      t.integer :ext_hrate
      t.integer :state, default: 0

      t.timestamps
    end
  end
end
