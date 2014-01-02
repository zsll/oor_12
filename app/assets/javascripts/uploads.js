var do_on_load = function() { 
  $('#s3_uploader').S3Uploader(
    { 
      remove_completed_progress_bar: false,
      progress_bar_target: $('#uploads_container'),
      allow_multiple_files: false
    }
  );
  $('#s3_uploader').bind('s3_upload_failed', function(e, content) {
    return alert(content.filename + ' failed to upload due to an error.');
  });
 
  $('#s3_uploader').bind('s3_upload_complete', function(e, content) {
  	//insert any post progress bar complete stuff here.
    $('#upload_direct_upload_url').val(content.url);
    $('#upload_file_file_name').val(content.filename);
    $('#upload_file_file_path').val(content.filepath);
    $('#upload_file_file_size').val(content.filesize);
    $('#upload_file_content_type').val(content.filetype);
  });
 
};
 
 
 
 
$(document).ready(do_on_load);
$(window).bind('page:change', do_on_load);