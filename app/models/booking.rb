class Booking < ActiveRecord::Base

  belongs_to :stay_home
  belongs_to :user
  has_many :payments,dependent: :destroy                  

  validate :last_date_greater_than_start_date_and_smaller_six_month
  validates :user_id, :start_date, :last_date, :stay_home_id, presence: true

  # belongs_to :room
  has_many :booking_dates, dependent: :destroy
  has_many :booking_rooms,dependent: :destroy
  has_many :rooms, through: :booking_rooms

    after_save :create_or_update_booking_dates
  
  # These attributes should always be present
  validates :start_date, :last_date, :num_of_room, :num_of_room , :user_id, presence: true

  # Custom valudation for check in date
  # Check in date cannot be in the past
   validate :start_date_cannot_be_in_the_past
   validate :last_date_should_be_less_than_start_date
   validate :last_date_cannot_be_more_than_6_months
   validate :room_availability_check
  
  delegate :merchant, to: :stay_home, allow_nil: true
  delegate :email, to: :merchant, allow_nil: true


  def last_date_greater_than_start_date_and_smaller_six_month 
    if dates_is_blank?
      return true
    elsif Date.today > start_date.to_date
      errors.add(:start_date, "check in date should be greater or equal to today's date")
    elsif Date.today + 6.months < last_date.to_date 
      errors.add(:last_date, "Check out date should be smaller than 6 months")
    elsif last_date.to_date < start_date.to_date
      errors.add(:last_date, "check out date should be greater than Check in Date")
    end
  end

  def self.excluded_id(start_date,last_date)
    if (b= Booking.where("Date(start_date) < ? AND Date(last_date) > ? ", last_date,start_date).collect(&:room_id)).empty?
      return false
    else
      return b
    end
  end

  def dates_is_blank?
    if start_date.blank? || last_date.blank?
      return true
    end
  end

  def room_type_int
    self.class.room_types[self.room_type]
  end


  private
  # Method for allowing booking only up to 6 months
  def last_date_cannot_be_more_than_6_months
    if last_date.present? && last_date > Date.today+6.months
      errors.add(:last_date, "can't be more than 6 months. Booking up to 6 months in advance.")
    end
  end 

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end 

  def last_date_should_be_less_than_start_date
    if start_date.present? && last_date.present? && last_date < start_date
      errors.add(:last_date, "can't be less than check in date")
    end
  end 

  def create_or_update_booking_dates
    if start_date_previously_changed? || last_date_previously_changed?
      # Delete all booking dates if check in or check out changed
      booking_dates.delete_all
      # Adding all the dates of the start_date and last_date range into the reserved dates
      (start_date..last_date).each do |reserved_date|  
        # Createing booking dates with specified reserved_date
        booking_dates.create(reserved_date: reserved_date)
      end
    end
  end

  # Method to validating room availability
  def room_availability_check
    if rooms.present? && !rooms.available?(start_date, last_date)
      errors.add(:rooms, "is not available right now and booked already")
    end
  end
end