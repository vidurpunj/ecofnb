class Gallery < ApplicationRecord
	mount_uploader :image, GalleryUploader

	validates :image,:presence => true
end
