class GalleriesController < ApplicationController
  def index
  	@galleries = Gallery.all.order('updated_at DESC')
  	@gallery_types = PhotogalleryType.all
  end

  def video
  	@videos = Video.all.order('updated_at DESC')
  end
end
