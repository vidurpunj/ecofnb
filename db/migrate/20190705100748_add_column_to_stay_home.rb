class AddColumnToStayHome < ActiveRecord::Migration[5.2]
  def change
  	add_column :stay_homes, :latitude , :float
  	add_column :stay_homes, :longitude , :float
  end
end
