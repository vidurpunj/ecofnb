class AddColumnToVideoTables < ActiveRecord::Migration[5.2]
  def change
  	add_column :videos, :active, :boolean 
  end
end
