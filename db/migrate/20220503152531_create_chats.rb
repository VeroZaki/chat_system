class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.integer :number
      t.integer :messages_count, default: 0

      t.references :application, null: false, index: true
      t.index [:number, :application_id], unique: true
      
      t.timestamps
    end
  end
end
