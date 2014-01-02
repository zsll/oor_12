class Upload < ActiveRecord::Base
  has_attached_file :file,
  :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/aws.yml",
    :path => ":class/:attachment/:id/:style/:filename",
    :url => ':s3_domain_url', 
    :styles => { 
      :large => "500x500>", 
      :tailored => {
        :geometry => "300x300^"
      }
    }
  validates :direct_upload_url, presence: true

  attr_accessible :direct_upload_url, :file_file_name, :file_file_size, :file_content_type, :file_file_path
  
  def self.copy_and_delete(paperclip_file_path, raw_source, delete = true)
    s3 = AWS::S3.new #create new s3 object
    destination = s3.buckets["#{ENV['S3_BUCKET_NAME']}-#{Rails.env}"].objects[paperclip_file_path]
    sub_source = CGI.unescape(raw_source)
    sub_source.slice!(0) # the file_file_path ends up adding an extra "/" in the beginning. We've removed this.
    source = s3.buckets["#{ENV['S3_BUCKET_NAME']}-#{Rails.env}"].objects["#{sub_source}"]
    source.copy_to(destination, :acl => "public-read") #copy_to is a method originating from the aws-sdk gem.
    if delete
      source.delete #delete temp file.
    end
  end
end
