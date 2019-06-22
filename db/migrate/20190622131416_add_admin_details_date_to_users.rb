class AddAdminDetailsDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :string
    add_column :users, :user_type, :string
  end
end
