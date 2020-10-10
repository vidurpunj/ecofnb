class AddColumnStayHomeStatus < ActiveRecord::Migration[5.2]
  def change
  	    add_column :stay_homes, :status, :string, :default => "pending"
  end
end
