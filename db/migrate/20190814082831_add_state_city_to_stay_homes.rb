class AddStateCityToStayHomes < ActiveRecord::Migration[5.2]
  def change
  	 add_column :stay_homes, :city, :string
  	 add_column :stay_homes, :state, :string
  end
end
