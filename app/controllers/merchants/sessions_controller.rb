# frozen_string_literal: true

class Merchants::SessionsController < Devise::SessionsController
  # include Accessible
  before_action :authenticate_merchant!, except: :new
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
     params[:email] = params[:merchant][:email].downcase
        merchant = Merchant.find_by(email: params[:email])
        if (merchant!=nil && merchant.valid_password?(params[:merchant][:password]) && merchant.status == 2)
           session[:merchant_id] = merchant.id
           sign_in(resource_name, merchant)
           redirect_to merchant_index_path
        elsif merchant.present? && (merchant.status == 1)
        begin
            merchant.save
             # UserMailer.admin_recv_merchnat_status_info(merchant).deliver_now
             flash[:notice]= "Your request will not approved by Admin, Admin will approve your status soon." 
            redirect_to new_merchant_session_url
        rescue
           flash[:notice] = "something is wrong please contact admin"
           redirect_to new_merchant_session_url
        end 
        else 
          flash[:notice] = "something is wrong please contact admin"
           redirect_to new_merchant_session_url
        end
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
