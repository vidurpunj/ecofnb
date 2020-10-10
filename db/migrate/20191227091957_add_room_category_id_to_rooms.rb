class AddRoomCategoryIdToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :room_category_id, :integer
  end
end
