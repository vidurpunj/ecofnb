class RemoveRoomCategoryIdFromBookingRooms < ActiveRecord::Migration[5.2]
  def change
  	remove_column :booking_rooms, :room_category_id
  end
end
