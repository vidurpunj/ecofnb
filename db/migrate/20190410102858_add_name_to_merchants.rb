class AddNameToMerchants < ActiveRecord::Migration[5.2]
  def change
  	add_column :merchants, :name, :string
  	add_column :merchants, :mobile, :integer
  	add_column :merchants, :address, :string
  end
end
