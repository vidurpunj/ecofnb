class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :video_link
      t.text :content

      t.timestamps
    end
  end
end
