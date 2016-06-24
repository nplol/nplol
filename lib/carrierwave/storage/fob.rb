CarrierWave.configure do |config|
  config.fog_provider = "fog/aws"
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["s3_access_key_id"],
    aws_secret_access_key: ENV["s3_access_key"],
    region: "eu-west-1",
    host: ENV["s3_host_name"]
  }
  config.fog_directoy = "nplol",
end
