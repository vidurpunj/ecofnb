class CreateStayHomes < ActiveRecord::Migration[5.2]
  def change
    create_table :stay_homes do |t|
      t.string :stay_name
      t.string :stay_title
      t.string :address
      t.text :description
      t.string :slug

      t.timestamps
    end
  end
end
