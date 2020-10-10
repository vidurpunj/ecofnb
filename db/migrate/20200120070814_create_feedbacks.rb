class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :message
      t.string :feedback_type 
      t.integer :role_id  
      t.timestamps
    end
  end
end
