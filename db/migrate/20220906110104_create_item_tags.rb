class CreateItemTags < ActiveRecord::Migration[6.1]
  def change
    create_table :item_tags do |t|
      t.integer :tag_id, null: false, foreign_key: true
      t.integer :item_id, null: false, foreign_key: true
      t.timestamps
    end
    add_index :item_tags, [:item_id,:tag_id],unique: true
  end
end
