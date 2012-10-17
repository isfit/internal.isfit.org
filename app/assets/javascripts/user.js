$(function() {
	$('.card_form').click(function() { 
		var div_button = $(this).children().last();
		$.ajax({
			type:'POST',
			url:'/users/status/update',
			data: $(this).serialize(),
			success: function(data) {
				if (div_button.hasClass("btn-success")) {
					div_button.removeClass("btn-success");
				}
				else {
					div_button.addClass("btn-success");
				}
			}	
		});

		
	});
});