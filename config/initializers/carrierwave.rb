CarrierWave.configure do |config|

  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      :provider               => 'AWS',     
      :aws_access_key_id      => ENV['aws_key_id'], 
      :aws_secret_access_key  => ENV['aws_key_secret'],
      :region                 => 'ap-south-1'  
      # :endpoint => 'http://s3.amazonaws.com'   
  }

  config.fog_directory  = 'ecofnb' # bucket name
  # config.asset_host     = 'ecofnb.ecofnb.s3.ap-south-1.amazonaws.com'
  config.fog_public     = true                        
  config.fog_attributes = { } 
end
