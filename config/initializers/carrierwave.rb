CarrierWave.configure do |config|
  unless Rails.env.test?
    AWS_CONFIG = Rails.application.secrets.aws_config

    config.storage    = :aws
    config.aws_bucket = AWS_CONFIG['s3_bucket_name']
    config.aws_acl    = :'public-read'
    config.asset_host = 'https://cdn.masinfinitocasa.com'
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

    config.aws_credentials = {
      access_key_id:     AWS_CONFIG['s3_key'],
      secret_access_key: AWS_CONFIG['s3_secret'],
      region:            AWS_CONFIG['s3_region']
    }
  end
end
