class CreateStayhomeFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :stayhome_facilities do |t|

      t.timestamps
    end
  end
end
