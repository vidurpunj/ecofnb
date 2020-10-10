class Merchant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :authentications                   
  has_many :stay_homes
  # has_many :payments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_mail_partner_or_admin

	STATUS = {
		unverified: 1,
		verified: 2,
		blocked: 3
	}.freeze
	
	STATUS_REVERSE = {
      1 => 'Unverified',
      2 => 'Verified',
      3 => 'Blocked'
  }.freeze
  
  def send_welcome_mail_partner_or_admin
      # UserMailer.welcome_merchant(self).deliver_now
      # UserMailer.admin_recv_merchnat_status_info(self).deliver_now
  end
end
