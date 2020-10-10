class CreateRoomCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :room_categories do |t|
      t.string :category_name
      t.integer :category_price, limit: 8

      t.timestamps
    end
  end
end
