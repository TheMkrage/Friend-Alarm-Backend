class CreateAlarms < ActiveRecord::Migration[5.2]
  def change
    create_table :alarms do |t|
      t.string :name
      t.integer :duration
      t.integer :user_id
      t.timestamps
    end
  end
end
