class AddingFeedableTypeAndId < ActiveRecord::Migration[5.2]
  def change
  	remove_column :feedbacks ,:feedback_type
  	remove_column :feedbacks, :feedback_id
  	add_column :feedbacks, :feedbackable_id , :integer
  	add_column :feedbacks, :feedbackable_type, :string
  end
end
