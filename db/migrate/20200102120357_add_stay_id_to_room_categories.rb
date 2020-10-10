class AddStayIdToRoomCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :room_categories, :stay_home_id, :integer
  end
end
