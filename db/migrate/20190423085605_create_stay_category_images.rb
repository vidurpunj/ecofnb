class CreateStayCategoryImages < ActiveRecord::Migration[5.2]
  def change
    create_table :stay_category_images do |t|
      t.integer :category_id
      t.integer :stay_home_id
      t.string :category_image

      t.timestamps
    end
  end
end
