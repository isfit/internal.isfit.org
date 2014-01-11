function add_person(){
  $('#select_person').slideUp('slow', function(){
    $('#contact_log_person').slideDown('slow', function() {
      $('#contact_log_contact_log_person_id').val('')
    });
  });
}
function select_person(){
  $('#contact_log_person').slideUp('slow', function() {
    $('#select_person').slideDown('slow', function(){
    });
  });
}

$(document).ready(function() {
	$('.contact_log, .sortable > thead > tr').find('th.sort').each(function(i) {
		$(this).append(' <i class="icon-chevron-up"></i> <i class="icon-chevron-down"></i>');
	});
});