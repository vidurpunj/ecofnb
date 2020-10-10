class CreateBookingRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_rooms do |t|

      t.timestamps
    end
  end
end
