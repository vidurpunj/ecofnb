class RatingReview < ApplicationRecord
	belongs_to :stay_home
	belongs_to :user


	def display_rating
			if self.new_record?
				0
			else
				(self.rating/2.0).round(1)
			end
	end

end
