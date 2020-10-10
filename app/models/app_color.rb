class AppColor < ApplicationRecord
	validate :check_record, on: :create
	validates :header_color, :header_hover, :presence => true

	private

	def check_record
	 if AppColor.all.count === 1
	   errors[:base] << "You can only have one active header color you also update color"
	 end
	end
end
