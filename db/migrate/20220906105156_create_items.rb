class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id, null: false, foreign_key: true
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price_without_tax, null: false
      t.boolean :is_stopped, null: false, default: false
      t.timestamps
    end
  end
end
