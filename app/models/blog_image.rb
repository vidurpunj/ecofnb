class BlogImage < ApplicationRecord
	mount_uploader :image, ImageUploader
end
