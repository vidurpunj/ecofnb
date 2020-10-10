class AddBookingIdToPayments < ActiveRecord::Migration[5.2]
  def change
  	add_column :payments, :booking_id, :integer
  end
end
