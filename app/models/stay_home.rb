class StayHome < ApplicationRecord
  has_many :stay_images,as: :immageable, dependent: :destroy
  accepts_nested_attributes_for :stay_images,  :allow_destroy => true,:reject_if => :all_blank
  has_many :rating_reviews, dependent: :destroy
  has_many :rooms ,dependent: :destroy
  belongs_to :stay
  belongs_to :merchant
  has_many :room_categories
  has_many :bookings

  extend FriendlyId
    friendly_id :stay_name, use: [:slugged, :finders]

    validates :stay_name, :stay_title, :address,:description,:presence => true
    has_many :stayhome_facilities, dependent: :destroy
    has_many :facilities, through: :stayhome_facilities
    validates :stay_images,:address ,:presence => true


    STATUS = { "1" => "Pending", "2" => "Approved", "3" => "Rejected" }.freeze
  #   STATUS = {
  #   Pending: 1,
  #   Approved: 2,
  #   Rejected: 3
  # }.freeze
  
  STATUS_REVERSE = {
      1 => 'Pending',
      2 => 'Approved',
      3 => 'Rejected'
  }.freeze

    scope :pending, -> { where(status: "1") }
    scope :approved, -> { where(status: "2") }
    scope :rejected, -> { where(status: "3") }
    scope :with_out_offer, -> {where(offer_id: nil)}

    def image_select
      if self.stay_images.any?
        self.stay_images.first.stay_image.url
      else
        "/assets/images/Home_stay/10.jpg"
      end
    end


    def image_select1
      if self.stay_images.any?
        self.stay_images.each do |stay_img|
          stay_img.stay_image.url
        end
      else
        "/assets/images/Home_stay/10.jpg"
      end
    end


    def avg_rating
    if self.rating_reviews.any?
      ((((self.rating_reviews.map(&:rating).reject { |item| item.nil? || item == '' }.inject(0){|sum,x| sum + x }))/2)/self.rating_reviews.count.to_f).round(1)
    else
      0.0
    end
  end

  def rating_reviews_info
    {
      avg_rating: avg_rating,
      rating_count: rating_reviews.where.not(rating: nil).count,
      review_count: rating_reviews.where.not(review: "").count,
      five_star_count: rating_reviews.star_count(10),
      four_star_count: rating_reviews.star_count(8),
      three_star_count: rating_reviews.star_count(6),
      two_star_count: rating_reviews.star_count(4),
      one_star_count: rating_reviews.star_count(2),
      rating: reviews
    }
  end

    def rating
    rating_info = []
    rating_info << {avrage_rating: avg_rating, total_raings: rating_reviews.count, reviews: reviews }
    return rating_info
  end

  def reviews
    review_data = []
    rating_reviews.limit(3).each do |review|
      review_data << {id: review.id, user: review.get_user_info, rating: review.rating, review: review.review}
    end
    return review_data
  end

  def reviews
    rating_arr = []
    rating_reviews.where.not(rating: nil).each do |rating|
      rating_arr << {id: rating.id, user: rating.user.get_name, title: "Best forever", rating: (rating.rating)/2, review: rating.review, created_at: rating.created_at, verified_buyer: true, flag: true, like: 26}
    end
    rating_arr
  end
#################rajeet  ##############
def self.search(search)

    if search
      # byebug

      ##############for categories#########
        to_find=search[:search]
        to_find=to_find.downcase
        ########for address ########
        @stay_categories=StayHome.joins(:stay).where("lower(stays.name) LIKE? OR lower( address) LIKE? OR city LIKE ? OR state LIKE ?", "%#{to_find}%","%#{to_find}%","%#{to_find}%","%#{to_find}%").where(status:2)
          return @stay_categories
    else
      return self.all
    end
  end


  ################## rajeet ###################
  # def self.search(search)

  #   if search
  #     location = Geocoder.search(search[:search])
  #     lat = location.first.latitude.truncate(1) rescue nil
  #     lng = location.first.longitude.truncate(1) rescue nil
  #     @stay_homes = self.where('latitude LIKE ? AND longitude LIKE ?', "%#{lat}%", "%#{lng}%").where(status: 2) if lat.present? && lng.present?
  #    if @stay_homes.blank?
  #       @stay_homes = self.where("address ILIKE ? OR city LIKE ? OR state LIKE ?', "%#{search[:search]}%","%#{search[:search]}%","%#{search[:search]}%").where(status: 2)
  #    end
  #     @hotel_rooms1 = @stay_homes.map{ |stay| stay.rooms.available_rooms(search[:start_date], search[:last_date] )}
  #       @stay_homes = @hotel_rooms1.flatten.map(&:stay_home_id).uniq
  #       @results=self.all.where(id: @stay_homes)
  #       return @results
  #    end
  # end

  def self.star_rating(search)
    if search[:star_rating].present?
      @stay_ids = []
      checked_rating = search[:star_rating].split(",")
      checked_rating.each do |rt|
      @stay_ids << self.all.select{ |stay| stay.avg_rating.floor >= rt.to_i }.map(&:id)
      end
      return self.all.where(id: @stay_ids.flatten.uniq)
    else
      self.all
    end
  end

  # def self.get_price(search)

  #   if search[:price].present?
  #     min = search["price"].split('-').first
  #     max = search["price"].split('-').last
  #     @price = self.all.where("stay_price >= :min AND stay_price <= :max", min: min, max: max)
  #   else
  #      self.all
  #   end
  # end

  def self.stay_type(search)
    if search[:stay_type].present?
      @stay_id = Stay.all.find(search[:stay_type])
      self.all.where(stay_id: @stay_id)
    else
      self.all
    end
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || self.stay_name_changed?
  end
end
