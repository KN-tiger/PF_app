class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :order_id, null: false, foreign_key: true
      t.integer :item_id, null: false, foreign_key: true
      t.integer :price_with_tax, null: false
      t.integer :amount, null: false
      t.integer :provision_status, null: false, default: 0
      t.timestamps
    end
  end
end
