$(function() {
	$('.edit_drive input[type=submit]').remove();
  $('.edit_drive #drive_status').change(function(){
 		$(this).closest("form").submit();
  });
});