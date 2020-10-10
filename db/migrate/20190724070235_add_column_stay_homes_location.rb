class AddColumnStayHomesLocation < ActiveRecord::Migration[5.2]
  def change
  	  	add_column :stay_homes, :location_description, :text
  end
end
