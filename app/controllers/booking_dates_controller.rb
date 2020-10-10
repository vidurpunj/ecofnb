class BookingDatesController < InheritedResources::Base

  private
    def booking_date_params
      params.require(:booking_date).permit(:reserved_date, :booking_id)
    end

end
