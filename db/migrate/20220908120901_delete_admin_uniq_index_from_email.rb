class DeleteAdminUniqIndexFromEmail < ActiveRecord::Migration[6.1]
  def change
    remove_index :admins, :email
    add_index :admins, :login_id, unique: true
  end
end
