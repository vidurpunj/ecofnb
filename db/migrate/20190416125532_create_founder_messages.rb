class CreateFounderMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :founder_messages do |t|
      t.string :image
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
