class AddBookingDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :booking_date, :datetime
  end
end
