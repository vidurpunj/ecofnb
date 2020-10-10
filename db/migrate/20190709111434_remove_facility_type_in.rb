class RemoveFacilityTypeIn < ActiveRecord::Migration[5.2]
  def change
  	add_column :facilities, :facility_type_id, :integer
  	remove_column :facilities, :facility_type, :integer
  end
end
