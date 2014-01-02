class AddFileFilePathToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :file_file_path, :string
  end
end
