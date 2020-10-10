class CreateStays < ActiveRecord::Migration[5.2]
  def change
    create_table :stays do |t|
      t.string :name

      t.timestamps
    end
  end
end
