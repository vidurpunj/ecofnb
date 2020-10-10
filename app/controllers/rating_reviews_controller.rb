class RatingReviewsController < ApplicationController
   before_action :authenticate_user!, :only => [:new, :index, :create]

    def index
      @rating_reviews=current_user.rating_reviews.all
    end

    def new 
      @rating_review= current_user.rating_reviews.new
    end

    def create
      @stayhome = StayHome.find(params[:id])
      @rating_review = @stayhome.rating_reviews.new(rating_review_params)
      @rating_review.user = current_user
      @rating_review.save
      redirect_to stay_path
    end

    private
    def rating_review_params
    	params.require(:rating_reviews).permit(:rating, :review, :stay_home_id, :title)
    end
end

