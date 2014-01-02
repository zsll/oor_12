class AddDirectUploadUrlToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :direct_upload_url, :string
  end
end
