class ChangeLatlongDataTypesInStayHome < ActiveRecord::Migration[5.2]
  def change
  	 change_column :stay_homes, :latitude, :string
  	 change_column :stay_homes, :longitude, :string
  end
end
