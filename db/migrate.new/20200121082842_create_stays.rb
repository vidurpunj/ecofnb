class CreateStays < ActiveRecord::Migration[5.2]
  def change
    create_table :stays do |t|

      t.timestamps
    end
  end
end
