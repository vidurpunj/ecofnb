module ApplicationHelper

	 def location_values(params)
    params[:stay_home][:address] if params[:stay_home].present?
  end

   def price_values(params)
    params[:search_parameters][:price] if params[:search_parameters].present?
  end

  def search_values(params)
   params[:search_parameters][:search] if params[:search_parameters].present?
  end

  def star_rating_values(params)
    params[:search_parameters][:star_rating] if params[:search_parameters].present?
  end

  def stay_type_values(params)
    params[:search_parameters][:stay_type] if params[:search_parameters].present?
  end

  def start_date_values(params)
    params[:search_parameters][:start_date] if params[:search_parameters].present? 
  end
  
  def last_date_date_values(params)
    params[:search_parameters][:last_date] if params[:search_parameters].present? 
  end
  
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  # def image_optimization(input_image)
  #   img_path = input_image.path
  #   image = MiniMagick::Image.open(img_path)
  #   image.resize "600x600"
  #   image.format "jpg"
  #   return image
  # end
end
