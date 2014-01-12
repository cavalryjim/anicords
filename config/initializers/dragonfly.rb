require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  protect_from_dos_attacks true
  secret "26ceb26c28eedcbc0ba21a2ff25b26d97a5fe3251c6e63c60f0276d6e0e9091b"

  url_format "/media/:job/:name"

  #datastore :file,
  #  root_path: Rails.root.join('public/system/dragonfly', Rails.env),
  #  server_root: Rails.root.join('public')
  datastore :s3,
    bucket_name: ENV["AWS_S3_BUCKET"],
    access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
