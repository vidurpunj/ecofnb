class AddRoomCategoryIdToBookingRooms < ActiveRecord::Migration[5.2]
  def change
  	add_column :booking_rooms, :room_category_id, :integer
  	add_column :bookings, :room_category_id, :integer
  end
end
