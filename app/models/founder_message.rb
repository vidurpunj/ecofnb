class FounderMessage < ApplicationRecord
	mount_uploader :image , FounderMessageUploader 
	validate :check_record, on: :create
	validates :image, :presence => true
	validates :image,:title,:description ,:presence => true

	private

	def check_record
	 if FounderMessage.all.count === 1
	   errors[:base] << "You can only have one active FounderMessage"
	 end
	end

end
