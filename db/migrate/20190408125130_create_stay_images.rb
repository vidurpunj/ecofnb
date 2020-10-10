class CreateStayImages < ActiveRecord::Migration[5.2]
  def change
    create_table :stay_images do |t|
      t.string :stay_image
      t.integer :stay_home_id

      t.timestamps
    end
  end
end
