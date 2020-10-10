class AddOtherToStayHomes < ActiveRecord::Migration[5.2]
  def change
    add_column :stay_homes, :other, :string
  end
end
