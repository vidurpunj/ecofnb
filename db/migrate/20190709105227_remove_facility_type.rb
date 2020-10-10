class RemoveFacilityType < ActiveRecord::Migration[5.2]
  def change
  	remove_column :facilities, :facility_type, :string
  	add_column :facilities, :facility_type, :integer
  end
end
