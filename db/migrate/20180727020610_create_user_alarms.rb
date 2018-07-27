class CreateUserAlarms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_alarms do |t|
      t.integer :alarm_id
      t.integer :owner_id
      t.integer :referrer_id
      t.boolean :is_secret, default: false
      t.boolean :is_high_priority, default: false
      t.timestamps
    end
  end
end
