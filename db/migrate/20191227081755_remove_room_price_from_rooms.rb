class RemoveRoomPriceFromRooms < ActiveRecord::Migration[5.2]
  def change
  	remove_column :rooms, :room_price
  	remove_column :rooms, :roomprice
  	remove_column :rooms, :roomcategory
  end
end
