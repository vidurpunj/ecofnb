class AboutU < ApplicationRecord
	mount_uploader :image , AboutUUploader 
	validate :check_record, on: :create
	validates :title,:description, :presence => true


	private

	def check_record
	 if AboutU.all.count === 1
	   errors[:base] << "You can only have one active AboutUs"
	 end
	end
end
