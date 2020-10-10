class StayHomesController < ApplicationController
  before_action :authenticate_merchant!
  before_action :set_lat_long, only: [:create, :update]
  skip_before_action :authenticate_merchant!, only: [:stay_status_approved]

   layout 'dashboard'

    def index
      # byebug
      @stay_homes= current_merchant.stay_homes.all
    end

  def new
  
    @stay_home =current_merchant.stay_homes.new
    @stay_home.stay_images
  end

    def create
     @stay_home = current_merchant.stay_homes.new(stayhome_params)
     # byebug
     
     if @stay_home.save
         params[:Facility].each do |ff|
             StayhomeFacility.create(stay_home_id: @stay_home.id, facility_id: ff)
         end
        UserMailer.admin_stay_status_approved(@stay_home , current_merchant).deliver_now
        redirect_to stay_homes_path
     else
        render 'new'
     end
  end  

   def show
    @stay_home =current_merchant.stay_homes.find(params[:id])
   end


   def edit
    @stay_home =current_merchant.stay_homes.find(params[:id])
  end


  def update
    @stay_home =current_merchant.stay_homes.find(params[:id])
      if @stay_home.update(stayhome_params)
        if params[:Facility].present?
          @stay_home.stayhome_facilities.destroy_all
          params[:Facility].each do |ff|
             StayhomeFacility.create(stay_home_id: @stay_home.id, facility_id: ff)
         end
        end
        
        redirect_to stay_homes_path
    else
      render 'edit'
    end
  end

  def find_lat_long
    if lat_long.first.coordinates.present?
          coordinate = lat_long.first.coordinates
          @stay_home.latitude = coordinate.first
          @stay_home.longitude = coordinate.last
       end
  end

  def destroy
      @stay_home = current_merchant.stay_homes.find(params[:id])
      if @stay_home.destroy
          redirect_to stay_homes_path
      end

  end

  def stay_status_approved
      @stay_home = StayHome.friendly.find(params[:id])
      if @stay_home.present?
        @stay_home.update(status: "2")
        redirect_to admin_user_session_path ,notice: "stay home status has been approved"
      else
        redirect_back fallback_location: root_path ,notice: "stay status not approved"
      end
  end

  private
# :stay_price,
    def stayhome_params
      params.require(:stay_home).permit(:stay_name, :location_description, :stay_rule, :cancellation_policy,:other, :stay_title, :address, :stay_id,:latitude,:longitude,:description,:city,:state, stay_images_attributes: [:id, :stay_image,:_destroy])
    end

    def set_lat_long
       @latitude =  params[:stay_home][:latitude]
       @longitude = params[:stay_home][:longitude]
    end

end
