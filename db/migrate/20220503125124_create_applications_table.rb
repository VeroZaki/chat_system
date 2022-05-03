class CreateApplicationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.string :token
      t.string :name
      t.integer :chats_count, default: 0
      t.index :token, unique: true

      t.timestamps
    end
  end
end