class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password

      t.string :desk
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
