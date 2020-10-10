module PaytmHelper
  require 'paytm/encryption_new_pg.rb'
  include EncryptionNewPG
  def generate_checksum
    new_pg_checksum(@paramList, ENV['PAYTM_MERCHANT_KEY']).gsub("\n",'')
  end

  def verify_checksum
    new_pg_verify_checksum(@paytmparams, @checksum_hash, ENV['PAYTM_MERCHANT_KEY'])
  end
end