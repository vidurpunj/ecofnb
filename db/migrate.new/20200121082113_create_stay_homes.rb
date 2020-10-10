class CreateStayHomes < ActiveRecord::Migration[5.2]
  def change
    create_table :stay_homes do |t|

      t.timestamps
    end
  end
end
