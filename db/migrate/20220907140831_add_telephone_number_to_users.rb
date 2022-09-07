class AddTelephoneNumberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :telephone_number, :string
  end
end
