class ImageProcessor
  @queue = :image_processor
  def self.perform(upload_id)
    sleep 7 #pretend to be busy
    puts "About to reprocess img: " + upload_id.to_s
    upload = Upload.find(upload_id)
    
    begin
      upload.file.reprocess!
    rescue Exception => ex
      puts ex.message
      puts ex.backtrace.join("\n")
    end
  end
end