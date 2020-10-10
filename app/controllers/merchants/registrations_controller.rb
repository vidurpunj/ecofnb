# frozen_string_literal: true

class Merchants::RegistrationsController < Devise::RegistrationsController
    
  before_action :configure_sign_up_params, only: [:create]
  
  layout 'dashboard', :only => [:edit,:update]
  
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mobile, :address])
  end

  def create
    puts "SENDGRID_USERNAME: #{ENV['SENDGRID_USERNAME']}"
    byebug
    @merchant = Merchant.new(sign_up_params)
      if @merchant.save
        flash[:notice] = "#{@merchant.name} your request has been successfully submitted, Admin will approve your status soon." 
        # flash[:alert] = "admin approved your accounts as soon as possible" 
         redirect_to new_merchant_session_url
      else
         flash[:error] = "#{@merchant .errors.full_messages}"
         render :new
      end  
    end

   def pertner_sign_up_with_email
    @merchant = Merchant.new
   end

  protected


  # If you have extra params to permit, append them to the sanitizer.
  
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :mobile, :address) } 
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :mobile, :address])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
