class AddingStayImagesAndRoomImagesAsPolymorphic < ActiveRecord::Migration[5.2]
  def change
  	add_column :stay_images, :immageable_id,:integer
  	add_column :stay_images, :immageable_type,:string
  end
end