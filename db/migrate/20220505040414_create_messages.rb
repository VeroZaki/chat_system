class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :number
      t.references :chat, null: false, index: true
      t.index [:number, :chat_id], unique: true

      t.timestamps
    end
  end
end
