CarrierWave.configure do |config|  
  config.storage = :aws
  config.ignore_integrity_errors = false
    config.ignore_processing_errors = false
    config.ignore_download_errors = false
    config.aws_credentials = {
      :access_key_id      => ENV.fetch('wasabi_access_key'),
      :secret_access_key  => ENV.fetch('wasabi_secret'),
      region: 'us-east-1'
    }
    config.aws_acl    = :public_read
    config.asset_host =  "https://jwfsupport-#{Rails.env}.s3.wasabisys.com"
    config.aws_bucket  = "jwfsupport-#{Rails.env.to_s}"


  # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

Aws.config.update({endpoint: 'https://s3.wasabisys.com'})