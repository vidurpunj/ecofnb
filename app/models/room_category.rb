class RoomCategory < ApplicationRecord
	has_many :rooms
	belongs_to :stay_home
	has_many :stay_images,as: :immageable, dependent: :destroy
    accepts_nested_attributes_for :stay_images,  :allow_destroy => true,:reject_if => :all_blank

end
