class CreateStayImages < ActiveRecord::Migration[5.2]
  def change
    create_table :stay_images do |t|

      t.timestamps
    end
  end
end
