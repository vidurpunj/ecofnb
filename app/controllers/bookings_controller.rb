class BookingsController < ApplicationController
  # before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_booking, only: [:edit, :update, :available_rooms, :search_rooms]
  before_action :authenticate_user!
    # layout false
  # layout 'application', :except => :invoice
  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = current_user.bookings.all
  end

  def invoice
    @booking = Booking.find(params[:booking_id])
    @payment = @booking.payments.first
    @stay = stayhome.find_by(id:@booking.stay_home_id)
    @merchant = merchant.find_by(id:@stay.merchant_id)
    respond_to do |format|
    format.html
    format.pdf do
     render pdf: "invoice",
     template: "bookings/invoice.html.erb",
     layout: 'pdf.html'
   end
  end
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    @booking = Booking.find(params[:id])
    @payment = @booking.payments.first
  end

  # GET /bookings/new
  def new
    

    if current_user.present?
      @booking = Booking.new
      @stay_home = StayHome.find(params[:id])
    else
      flash[:notice] = "Please Login Before Booking"
      redirect_to "/users/sign_in"
    end
    @stay_home = StayHome.find(params[:id])
    @stay_images = @stay_home.stay_images.drop(1)
    @stayhome_facilities = @stay_home.facilities
    @resent_stay_home = StayHome.all.where.not(id: @stay_home).limit(3)
  end

  def search_rooms
  end
  #to check
  def available_rooms
    @booking = current_user.bookings.new(booking_params)
    # byebugt (BookingsController#available_rooms i
    @hotel_rooms = @bookings.rooms.where(room_category_id: params[:booking][:room_category_id]).available_rooms(params[:booking][:start_date], params[:booking][:last_date],params[:booking][:room_id], params[:booking][:room_category_id])
    # @hotel_rooms = @bookings.rooms.where(room_category_id: params[:booking][:room_category_id]).available_rooms(params[:booking][:start_date], params[:booking][:last_date],params[:booking][:room_id], params[:booking][:room_category_id])
    @total_number_days=(Date.parse(params[:booking][:last_date])-Date.parse(params[:booking][:start_date])).to_i
  #   respond_to do |format|
  #   format.js {render available_rooms_stay_bookings_path(@booking)}
  # end

  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    # byebug
    @booking = current_user.bookings.new(booking_params)
    @booking.stay_home_id = StayHome.friendly.find(params[:stay_id]).id
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @bookings = StayHome.friendly.find(params[:stay_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:start_date, :last_date, :stay_home_id, :room_id, :room_category_id, :user_id, :num_of_user,:num_of_room)
    end
end
