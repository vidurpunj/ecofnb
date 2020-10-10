class AddColumnStayHomeMerchantId < ActiveRecord::Migration[5.2]
  def change
  	    add_column :stay_homes, :merchant_id, :integer
  end
end
