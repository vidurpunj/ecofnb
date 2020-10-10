class ChangeRatingType < ActiveRecord::Migration[5.2]
  def change
  	remove_column :rating_reviews, :review, :integer
  	add_column :rating_reviews, :review, :string
  	add_column :rating_reviews, :title, :string
  end
end
