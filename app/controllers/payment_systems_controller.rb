class PaymentSystemsController < ApplicationController
  include PaytmHelper
  protect_from_forgery except: [:verify_payment]

  def start_payment

    @booking = current_user.bookings.new(booking_params)
    @stay = StayHome.friendly.find(params[:stay_id])
    @hotel_rooms = @stay.rooms.where(room_category_id: params[:booking][:room_category_id]).available_rooms(params[:booking][:start_date], params[:booking][:last_date],params[:booking][:room_id], params[:booking][:room_category_id]).limit(@booking.num_of_room)
    @booking.stay_home_id = StayHome.friendly.find(params[:stay_id]).id
    @total_number_days=(Date.parse(params[:booking][:last_date])-Date.parse(params[:booking][:start_date])).to_i
    if @total_number_days==0
    @total_price= (@booking.num_of_room) * (RoomCategory.find_by_id(@booking.room_category_id).category_price)
    else
    @total_price= (@total_number_days) *(@booking.num_of_room) * (RoomCategory.find_by_id(@booking.room_category_id).category_price)
    end
    # @stay.try(:stay_price) * 
    session[:booking] = @booking
    session[:booking_available_rooms] = @hotel_rooms
    paramList = Hash.new
    paramList["MID"] =  ENV['MID']
    paramList["ORDER_ID"] = "#{Time.now.to_i.to_s}"
    paramList["CUST_ID"] = "#{Time.now.to_i.to_s}"
    paramList["INDUSTRY_TYPE_ID"] = ENV['INDUSTRY_TYPE_ID']
    paramList["CHANNEL_ID"] = ENV['CHANNEL_ID']
    paramList["TXN_AMOUNT"] = @total_price
    paramList["MSISDN"] = current_user.phone
    paramList["EMAIL"] = current_user.email
    paramList["WEBSITE"] = ENV['WEBSITE']
    paramList["CALLBACK_URL"] = ENV['CALLBACK_URL']
    @paramList = paramList
    @checksum_hash = generate_checksum()
    respond_to do |format|
      format.js
      format.html
    end
  end 

  def verify_payment
    
    paytmparams = Hash.new
    keys = params.keys
    keys.each do |k|
      paytmparams[k] = params[k]
    end
    @checksum_hash = paytmparams["CHECKSUMHASH"]
    

    paytmparams.delete("CHECKSUMHASH")
    paytmparams.delete("controller")
    paytmparams.delete("action")
    @paytmparams = paytmparams
    @is_valid_checksum = verify_checksum()

    

    # if @is_valid_checksum == true
      if @paytmparams["STATUS"] == "TXN_SUCCESS"
        puts "payment vijay TXN_SUCCESS"
        @booking = session[:booking]
        @booking.delete('id')
        @booking_data = current_user.bookings.new(@booking)
        respond_to do |format|
          @booking_data.save!
          session[:booking_available_rooms].each do |room|
            @booking_data.booking_rooms.create(room_id: room["id"])
          end
          @create_payment = create_payment
          @create_payment.save!
          
          UserMailer.checkout_email(current_user, @booking_data, @create_payment).deliver_now
          UserMailer.merchantcheckout_email(current_user, @booking_data,@create_payment).deliver_now
          UserMailer.admincheckout_email(current_user,@booking_data,@create_payment).deliver_now
          format.html { redirect_to @booking_data, notice: 'Booking was successfully created.' }
        end
      else
      #     add logic unique to your app
        respond_to do |format|
          format.html
        end
      end
    # end
  end

  def create_payment
    @payment = Payment.new
    @payment.order_id = params[:ORDERID]
    @payment.txn_id = params[:TXNID]
    @payment.txn_amount = params[:TXNAMOUNT]
    @payment.payment_mode = params[:PAYMENTMODE]
    @payment.txn_date = params[:TXNDATE]
    @payment.status = params[:STATUS]
    @payment.getway = params[:GATEWAYNAME]
    @payment.bank_txn_id = params[:BANKTXNID]
    @payment.booking_id = @booking_data.id
    if params[:BANKNAME].nil?
      @payment.bank_name = params[:BANKNAME]
    end
    return @payment
  end

  private

  def booking_params
      params.require(:booking).permit(:start_date, :last_date, :stay_home_id, :room_id, :user_id, :num_of_user,:num_of_room, :room_category_id)
    end
end