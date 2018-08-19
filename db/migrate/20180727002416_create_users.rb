class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :facebook_connection
      t.string :apn_token
      t.timestamps
    end
  end
end
