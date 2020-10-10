class StayImage < ApplicationRecord
	mount_uploader :stay_image, StayImageUploader
	belongs_to :stay_home, required: false
	validates :stay_image, :presence => true
end
