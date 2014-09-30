$(function() {
	$('.small_edit_drive input[type=submit]').remove();
  $('.small_edit_drive #drive_status').change(function(){
 		$(this).closest("form").submit();
  });
});