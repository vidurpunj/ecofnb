class BlogsController < ApplicationController
  include ApplicationHelper
  # skip_before_action :verify_authenticity_token 
  def index
  	@per_page = params[:per_page].present? ? params[:per_page] : 10
    @blogs = Blog.all.order('updated_at DESC').page(params[:page]).per(@per_page)
  end

  def show
  	@blog = Blog.find(params[:id])
  	@resent_post = Blog.all.order("updated_at DESC").limit(3)
  end

  def ckeditor_picture
  	@picture = BlogImage.new(image: params[:upload])
    @picture.save
  end
  def time_ago_in_words(from_time, include_seconds_or_options = {})
    distance_of_time_in_words(from_time, Time.now, include_seconds_or_options)
  end
end