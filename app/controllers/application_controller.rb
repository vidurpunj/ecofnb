class ApplicationController < ActionController::Base
	# before_action :configure_permitted_parameters, if: :devise_controller? 
	before_action :configure_permitted_parameters , if: :devise_controller?

  # before_action :check_app_color
  protect_from_forgery with: :exception
  after_action :store_location
  before_action :get_footer_details
  skip_before_action :verify_authenticity_token

  


    def merchants_status_approved
      @merchant = Merchant.all.find_by_id(params[:id].to_i)
      if @merchant.present?
        if @merchant.status = 1
          @merchant.update(status: 2)
          UserMailer.merchant_account_approve_notification(@merchant).deliver_now
          redirect_to admin_user_session_path ,notice: "Partner status has been #{Merchant::STATUS_REVERSE[@merchant.status]}"
        elsif @merchant.status = 3
            UserMailer.merchant_account_approve_notification(@merchant).deliver_now
            redirect_to admin_user_session_path ,notice: "Partner status has been #{Merchant::STATUS_REVERSE[@merchant.status]}"
        else
          redirect_back fallback_location: root_path ,notice: "Partner status already Verified"
        end
      else
        redirect_back fallback_location: root_path ,notice: "Partner is not present"
      end
    end

  protected

    def store_location
      # store last url - this is needed for post-login redirect to whatever the user last visited.
      return unless request.get?
      if (request.path != "/users/sign_in" &&
          request.path != "/users/sign_up" &&
          request.path != "/users/sign_out" &&
          request.path != "/merchants/sign_in" &&
          request.path != "/merchants/sign_out" &&
          request.path != "/admin/login" &&
          request.path != "/admin/logout" &&
          !request.xhr?) # don't store ajax calls
          session[:previous_url] = request.fullpath
      end
    end
    
    def after_sign_in_path_for(resource)
      if current_merchant
        merchant_index_path
      elsif current_user && session[:previous_url] != nil
          session[:previous_url]
      elsif current_user.present?
          root_path    
      elsif current_admin_user && request.fullpath == "/admin/login"
        admin_root_path
      end
    end

    def after_sign_out_path_for(resource)
      if resource == :user
        root_path
      elsif resource == :merchant
        root_path
      else
        root_path
      end
    end

    def configure_permitted_parameters
  	 if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:last_name,:phone,:terms_of_service])
  	 end
    end
    
    def get_footer_details
      @latest_stay = StayHome.all.where(status:"2").order('updated_at DESC').limit(4)
      @latest_post = Blog.all.order("updated_at DESC").limit(3)
      @about_u = AboutU.last
      @stay_categories = Stay.all.order("updated_at DESC")
    end


end