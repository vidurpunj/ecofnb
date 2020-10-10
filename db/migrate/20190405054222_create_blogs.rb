class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :image
      t.string :title
      t.string :role
      t.text :upper_description
      t.text :quotation
      t.text :lower_description
      t.string :slug

      t.timestamps
    end
  end
end
