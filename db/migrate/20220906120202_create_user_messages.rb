class CreateUserMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :user_messages do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :room_id, null: false, foreign_key: true
      t.text :massage, null: false
      t.timestamps
    end
  end
end
