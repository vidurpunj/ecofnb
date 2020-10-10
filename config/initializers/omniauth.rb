
Rails.application.config.middleware.use OmniAuth::Builder do
	
    provider :google_oauth2, ENV.fetch('GOOGLE_CLIENT_ID'), ENV.fetch('GOOGLE_CLIENT_SECRET')
    
    provider :facebook, ENV.fetch('FACEBOOK_CLIENT_ID'), ENV.fetch('FACEBOOK_CLIENT_SECRET')
   
end