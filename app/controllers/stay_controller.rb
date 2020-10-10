class StayController < ApplicationController

	  def show
  		@stay_home = StayHome.find(params[:id])
	  	@stay_images = @stay_home.stay_images.drop(1)
	  	@stayhome_facilities = @stay_home.facilities
	  	@resent_stay_home = StayHome.all.where.not(id: @stay_home).limit(3)
	    @rating_reviews=RatingReview.all
	end
end                  