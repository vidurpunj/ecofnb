class UserMailer < ApplicationMailer
	def checkout_email(user, booking_data, create_payment)
    @user = user
    @booking_data = booking_data
    @create_payment = create_payment
    mail(to: @user.email, subject: 'Your booking with us has been accepted.')
  end

  def admincheckout_email(user, booking_data, create_payment)
    @adminuser = AdminUser.last
    @booking_data = booking_data
    @create_payment = create_payment
    mail(to: "ecofnb18@gmail.com", subject: "Booking Successfully")
  end

  def welcome_user(resource)
  
    @user = resource
    @email = @user.email
    mail(to: @email, subject: "Thank you for joining with us!")
  end

  def welcome_merchant(resource)
    @user = resource
    @email = @user.email
    mail(to: @email, subject: "Thank you for joining with us!")
  end

  def admin_stay_status_approved(stay_home ,merchant)
      @stay_home = stay_home
      @merchant = merchant
      mail(to: "ecofnb18@gmail.com", subject: "New Stay Approval Request")
  end

  def admin_recv_merchnat_status_info(resource)
    @merchant = resource
    mail(to: "ecofnb18@gmail.com", subject: "Partner Status Approval Request")
  end

  def merchantcheckout_email(user, booking_data, create_payment)
    @user = user
    @booking_data = booking_data
    @create_payment = create_payment
    @email=booking_data.merchant.email

    mail(to: @email, subject: "your stay is booked")
  end
  
  def afterUserSignUp (user)
     mail(to: "ecofnb18@gmail.com", subject: "New User Added")
  end 

  def merchant_stay_status(stay_home)
    @stay_home =stay_home
    @email = @stay_home.merchant.email
    mail(to: @email, subject: "Your Stay Home Status")
  end

  def merchant_account_approve_notification(merchant)
    # byebug
    @merchant = merchant
     mail(to: @merchant.email, subject: "Partner Accounts Status Informations")
  end

end
