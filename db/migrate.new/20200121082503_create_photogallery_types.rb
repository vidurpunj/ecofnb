class CreatePhotogalleryTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :photogallery_types do |t|

      t.timestamps
    end
  end
end
