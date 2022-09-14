class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :order_status, null: false, default: 0
      t.string :delivery, null: false
      t.date :deadline, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method, null: false, default: 0
      t.text :note
      t.timestamps
    end
  end
end
