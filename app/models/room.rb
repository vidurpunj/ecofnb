class Room < ApplicationRecord
	belongs_to :stay_home
  belongs_to :room_category
	has_many :booking_rooms
  has_many :bookings, through: :booking_rooms

  validates :name, :stay_home_id,:presence => true
	scope :available?, -> (start_date, last_date=nil) {
   available_rooms(start_date, last_date).present? }
  # Scope for finding all the available rooms
  # scope :available_rooms, -> (room_id, room_category_id, start_date, last_date=nil) {
  #   last_date = start_date if last_date.nil?
  #   # Fetching all the booked rooms in the particular date range
  #   hotel_rooms = includes(:bookings=>:booking_dates).where("booking_dates.reserved_date": start_date..last_date)
  #   # Filtering all the booked rooms and finding out the available rooms for particular
  #   where.not(id: hotel_rooms.map(&:id))
  # }
################room_id room_categopry_id ###############
  def self.available_rooms(start_date=nil,last_date=nil,room_id=nil , room_category_id=nil)
		# byebug
		last_date = start_date if last_date.nil?
    # Fetching all the booked rooms in the particular date range
    hotel_rooms = includes(:bookings =>:booking_dates).where("booking_dates.reserved_date": start_date..last_date)
    # Filtering all the booked rooms and finding out the available rooms for particular
    where.not(id: hotel_rooms.map(&:id))
		# byebug
  end
# def self.available_rooms( room_id=nil,room_categopry_id=nil,start_date, last_date=nil)
#     last_date = start_date if last_date.nil?
#     # Fetching all the booked rooms in the particular date range
#     hotel_rooms = includes(:bookings =>:booking_dates).where("booking_dates.reserved_date": start_date..last_date)
#     # Filtering all the booked rooms and finding out the available rooms for particular
#     where.not(id: hotel_rooms.map(&:id))
#   end

  # Checking if particular room is avaliable or not
  def available?(start_date, last_date=nil)
    last_date = start_date if last_date.nil?
    # we are also able to search for one day booking
    # dates we are taking as yyyy/mm/dd
    # example available("2016/10/9")
    # example available("2016/10/2","2016/10/9")
    # searching bookings using start_date and last_date date range
    bookings.joins(:booking_dates).where("booking_dates.reserved_date": start_date..last_date).blank?
  end
end
