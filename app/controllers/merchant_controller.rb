class MerchantController < ApplicationController
  before_action :authenticate_merchant!
  
  layout 'dashboard'
  
  def index
  end


  def booking_order
  	@stay_home=current_merchant.stay_homes
  	@booking_orders=Booking.all.where(stay_home_id: @stay_home.ids)
  end

  def profile
  
  end

end

