class CreateDevProfiles < ActiveRecord::Migration
  def self.up
    create_table :dev_profiles do |t|
      t.belongs_to :user
      t.integer :hourly_rate, :ext_hourly_rate, default: 0, null: false
      t.string :github, :twitter, :gsm, :facebook, :limit => 50
      t.timestamps
    end

    add_index :dev_profiles, :user_id, unique: true

    execute 'INSERT INTO dev_profiles(user_id, hourly_rate, ext_hourly_rate, created_at, updated_at) SELECT id, 0, 0, now(), now() FROM users'
  end

  def self.down
    drop_table :dev_profiles
  end
end
