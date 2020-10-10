class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password, :confirmation => true

  has_many :bookings
  has_many :rating_reviews
  validates :terms_of_service, acceptance: { message: 'must be abided' }

  validates :name, :email, :presence => true                   
  has_many :authentications

  after_create :send_welcome_mail


  def send_welcome_mail
    UserMailer.welcome_user(self).deliver_now
    UserMailer.afterUserSignUp(self).deliver_now
  end
end
