class AddingIdFieldIntoFeedbacks < ActiveRecord::Migration[5.2]
  def change
  	add_column :feedbacks, :feedback_id ,:integer
  end
end
