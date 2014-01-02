class UploadsController < ApplicationController
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @uploads }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    @upload = Upload.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new
    @upload = Upload.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
    @upload = Upload.find(params[:id])
  end

  # POST /uploads
  # POST /uploads.json
  def create
    if(params[:url])
      @upload = Upload.new
      render "new" and return
    end

    if(params[:upload][:file_file_path])
      @upload = Upload.new(params[:upload])
      respond_to do |format|
        if @upload.save
          #we want a destination(paperclip_file_path) and a source(raw_source)
          raw_source = params[:upload][:file_file_path]
          
          paperclip_file_path = "uploads/files/#{@upload.id}/original/#{params[:upload][:file_file_name]}"
          Upload.copy_and_delete paperclip_file_path, raw_source, false #this is where we call a method to copy from temp location to where paperclip expects it to be.
         
          @upload.file.reprocess!
          
          format.html { redirect_to upload_path(:id => @upload.id), notice: 'upload was successfully created.' }
          format.json { render action: 'show', status: :created, location: @upload }
        else
          format.html { render action: 'new' }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      end
    else
      @upload = upload.new
      render action: 'new', notice: "No file"
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end
end
