class CreateStayhomeFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :stayhome_facilities do |t|
      t.integer :stay_home_id
      t.integer :facility_id

      t.timestamps
    end
  end
end
