class CreateRatingReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :rating_reviews do |t|

      t.timestamps
    end
  end
end
