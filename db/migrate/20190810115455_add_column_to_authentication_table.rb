class AddColumnToAuthenticationTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :authentications, :merchant_id, :integer
  end
end
