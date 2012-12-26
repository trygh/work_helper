class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.integer :user_id
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :hourly_rate

      t.timestamps
    end
  end
end
