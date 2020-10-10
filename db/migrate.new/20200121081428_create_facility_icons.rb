class CreateFacilityIcons < ActiveRecord::Migration[5.2]
  def change
    create_table :facility_icons do |t|

      t.timestamps
    end
  end
end
