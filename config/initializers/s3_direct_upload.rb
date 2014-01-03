S3DirectUpload.config do |c|
  c.access_key_id     = ENV['AWS_ACCESS_KEY_ID']
  c.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  c.bucket            = "#{ENV['S3_BUCKET_NAME']}-#{Rails.env}"
  c.region            = "s3"  #This is required or it will cause https://github.com/waynehoover/s3_direct_upload/issues/30
  c.url = "https://s3.amazonaws.com/#{c.bucket}"
end