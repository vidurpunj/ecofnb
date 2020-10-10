class SessionsController < ApplicationController

  def new
  end

  def create
    
    if request.env['omniauth.origin'].split("/")[3] == "users"
  	 user = Authentication.from_omniauth(request.env["omniauth.auth"])
      if user
        flash[:notice] = "Authentication successful."
        sign_in(user)
        sign_in_and_redirect(user)
      else
          flash[:error] = "Authentication Failed."
          redirect_to new_user_session_path
      end
    else
       merchant = Authentication.from_omniauth1(request.env["omniauth.auth"])
      if merchant.status == 2
          flash[:notice] = "Authentication successful."
          sign_in(merchant)
          sign_in_and_redirect(merchant)
        elsif merchant.status == 1
            flash[:error]= "Your request will not approved by Admin, Admin will approve your status soon." 
            redirect_to new_merchant_session_url
        else
            flash[:error]= "something is wrong please contact admin"
             redirect_to new_merchant_session_url
      end
    end
  end


  def failure
     flash[:error]= "something is wrong please contact admin"
     redirect_to root_path
  end

end
