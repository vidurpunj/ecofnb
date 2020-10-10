class CreateFacilityTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :facility_types do |t|

      t.timestamps
    end
  end
end
