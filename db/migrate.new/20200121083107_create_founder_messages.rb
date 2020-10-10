class CreateFounderMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :founder_messages do |t|

      t.timestamps
    end
  end
end
