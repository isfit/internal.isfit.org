$(document).ready(function() {

	$('#gallery_fileupload').fileupload({
	  dataType: 'json',
	  url: $('.file_upload').attr('action'),
	  add: function (e, data) {
		console.debug(data);
	    data.submit();
	  },
	  dropzone: $("form.file_upload"),
	  done: function (e, data) {
	    $("#imagesList").append("<img src=/system/photos/"+data.photo.id+"/original/"+data.photo.photo_file_name+" id='front_large' />");
	    $("#gallery_photos_id_list").append(" " + data.photo.id);
	  }
	});
	
});