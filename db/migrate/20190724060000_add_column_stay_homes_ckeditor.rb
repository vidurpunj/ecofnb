class AddColumnStayHomesCkeditor < ActiveRecord::Migration[5.2]
  def change
  	add_column :stay_homes, :stay_rule, :text
  	add_column :stay_homes, :cancellation_policy, :text
  	add_column :stay_homes, :stay_price, :integer
  end
end
