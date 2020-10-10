class Authentication < ApplicationRecord
	belongs_to :user
  belongs_to :merchant
	validates :provider, :uid, :presence => true


    def self.from_omniauth(auth)
         authenticate = where(provider: auth['provider'], :uid=>auth['uid']).first_or_initialize
          if (authenticate.user==nil)
              user = User.find_by(email: auth.info.email) #trust google or facebook callback
              if (user==nil)
                  # Create a new user with a random password
                   user = User.new
                  authenticate.provider = auth.provider
                  authenticate.uid = auth.uid
                  authenticate.token = auth.credentials.token
                  user.email = auth.info.email
                  user.name = auth.info.name
                  user.password =  Devise.friendly_token.first(8)
                  
              else
                  # Add user login to existen user
                   authenticate.provider = auth.provider
                   authenticate.uid = auth.uid
                   authenticate.token = auth.credentials.token
              end
              user.save
              authenticate.user_id = user.id
              authenticate.save
              return authenticate.user
          end
          return authenticate.user
      end


      def self.from_omniauth1(auth)
           authenticate = where(provider: auth['provider'], :uid=>auth['uid']).first_or_initialize
               if (authenticate.merchant==nil)
                  merchant = Merchant.find_by(email: auth.info.email) #trust google or facebook callback
                  if (merchant==nil)
                      # Create a new merchant with a random password
                       merchant = Merchant.new
                      authenticate.provider = auth.provider
                      authenticate.uid = auth.uid
                      authenticate.token = auth.credentials.token
                      merchant.email = auth.info.email
                      merchant.name = auth.info.name
                      merchant.password =  Devise.friendly_token.first(8)
                      
                  else
                      # Add merchant login to existen merchant
                       authenticate.provider = auth.provider
                       authenticate.uid = auth.uid
                       authenticate.token = auth.credentials.token
                  end
                  merchant.save
                  authenticate.merchant_id = merchant.id
                  authenticate.save
                  return authenticate.merchant
              end
              return authenticate.merchant
          end

end
