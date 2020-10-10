class CreateStayCategoryImages < ActiveRecord::Migration[5.2]
  def change
    create_table :stay_category_images do |t|

      t.timestamps
    end
  end
end
