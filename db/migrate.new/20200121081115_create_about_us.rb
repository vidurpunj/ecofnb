class CreateAboutUs < ActiveRecord::Migration[5.2]
  def change
    create_table :about_us do |t|

      t.timestamps
    end
  end
end
