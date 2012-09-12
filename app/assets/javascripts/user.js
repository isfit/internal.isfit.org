$(function() {
	$('.card_form').click(function() { 
		$.ajax({
			type:'POST',
			url:'update',
			data: $(this).serialize()
		});

		var div_button = $(this).children().last()

		if (div_button.hasClass("btn-success"))
			div_button.removeClass("btn-success");
		else
			div_button.addClass("btn-success");
		
	});
});