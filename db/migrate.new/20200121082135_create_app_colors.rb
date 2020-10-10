class CreateAppColors < ActiveRecord::Migration[5.2]
  def change
    create_table :app_colors do |t|

      t.timestamps
    end
  end
end
