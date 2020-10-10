class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.string :image
      t.string :pg_type
      t.timestamps
    end
  end
end
