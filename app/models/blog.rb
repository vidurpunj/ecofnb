class Blog < ApplicationRecord
	mount_uploader :image, ImageUploader 

	extend FriendlyId
	  friendly_id :title, use: [:slugged, :finders]
	  validates :title, :image,:presence => true

end
