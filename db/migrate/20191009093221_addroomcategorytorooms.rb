class Addroomcategorytorooms < ActiveRecord::Migration[5.2]
  def change
  	add_column :rooms, :roomprice, :string
  	add_column :rooms, :roomcategory, :string
  end
end
