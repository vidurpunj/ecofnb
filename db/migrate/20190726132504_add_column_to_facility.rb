class AddColumnToFacility < ActiveRecord::Migration[5.2]
  def change
  	add_column :facilities, :facility_icon_id, :integer
  end
end
