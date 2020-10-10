class ChangeDefaultStatusStayhomes < ActiveRecord::Migration[5.2]
  def change
  	    remove_column :stay_homes, :status, :string, :default => "pending"
  	    add_column :stay_homes, :status, :string, :default => "1"
  end
end
