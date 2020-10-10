class RemvingFieldsFromFeedbackTable < ActiveRecord::Migration[5.2]
  def change
  	remove_column :feedbacks ,:role_id
  end
end
