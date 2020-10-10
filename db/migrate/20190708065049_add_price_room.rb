class AddPriceRoom < ActiveRecord::Migration[5.2]
  def change
  	add_column :rooms, :room_price, :integer
  end
end
