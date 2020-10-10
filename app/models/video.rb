class Video < ApplicationRecord
	YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  validates :video_link, presence: true, format: YT_LINK_FORMAT

  def convert
  	self.video_link.split("=")[1].split("&").first
  end
end

