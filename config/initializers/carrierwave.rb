CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["AKIAIQ63TRRUMH3Q5V3A"],
    aws_secret_access_key: ENV["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"]
  }
  config.fog_directory = ENV["Dolittl"]
end

