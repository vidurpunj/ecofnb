class ChangeColumnTypeMerchantMobile < ActiveRecord::Migration[5.2]
  def change
  	    remove_column :merchants, :mobile, :integer
  	    add_column :merchants, :mobile, :string
  end
end
