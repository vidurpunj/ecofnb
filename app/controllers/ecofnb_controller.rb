class EcofnbController < ApplicationController

  def index
    @videos = Video.all.where(active: true)
    @galleries = Gallery.all.order('updated_at DESC')
    @gallery_types = PhotogalleryType.all
    # byebug
    @homestays = StayHome.all.where(status:"approved").order('updated_at DESC').limit(6)
    @homestay_left = @homestays.limit(3)
    @homestay_right = @homestays.where.not(id: @homestay_left).limit(3)
    @h_stay_last = StayHome.all.order('updated_at DESC').last
    end

  def all_stay_homes    
     
     if params[:search_parameters].present?
        @stay_homes = search(params[:search_parameters])
    else
      
      @stay_homes = StayHome.all.where(status: 2)
    end
  end

  def about
    @about_us = AboutU.all.last
  end

  def founder_message
    @founder_message = FounderMessage.all.last
  end

  def ecofriendly
  end

  def stay_category
      @stay_category = Stay.find(params[:stay_id]) 
      # byebug
      @homestays = @stay_category.stay_homes.approved
  end

  def search(params)
    ###########rajeet ##############
    @search =StayHome.search(params).star_rating(params).stay_type(params)
    if params[:price].present?  
      min = params["price"].split('-').first
      max = params["price"].split('-').last
      @price_search_data=@search.joins(:room_categories).where("room_categories.category_price": min..max).uniq 
      return @price_search_data
  end 
  return @search
    #################rajeet###########
  end

  def signup_with_email

  end

end