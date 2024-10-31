require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = ENV['S3_BUCKET_NAME'] # 環境変数でバケット名を指定
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_ACCESS_KEY_ID'], # 環境変数名を修正
      aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'], # 環境変数名を修正
      region: ENV['S3_REGION'], # 環境変数でリージョンを指定
      path_style: true
    }
  end
end
