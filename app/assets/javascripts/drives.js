$(function() {
	$('.small_edit_drive input[type=submit]').remove();
  $('.small_edit_drive #drive_status').change(function(){
 		$(this).closest("form").submit();
  });
});

$(function() {
	$('#calendar').fullCalendar({
		header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
		},
		defaultView: 'agendaWeek',
		firstDay: 1,
		timeFormat: 'HH(:mm)',
		allDayDefault: false,
	    eventSources: [

	        // your event source
	        {
	            url: 'dashboard.json', // use the `url` property
	            color: '#3498db',    // an option!
	            textColor: 'black'  // an option!
	        }

	        // any other sources...

	    ],
	    eventRender: function(event, element) {
	    	var string = '';
	    	string += '<strong>Status</strong><br>' + event.status + '<br>';
	    	string += '<strong>Group</strong><br>' + event.group + '<br>';
	    	if (event.driver) {
	    		string += '<strong>Driver</strong><br>' + event.driver + '<br>';
	    	};
	    	if (event.car) {
	    		string += '<strong>Car</strong><br> ' + event.car + '<br>';
	    	};
	    	string += '<strong>Contact</strong><br>' + event.contact + '<br>';
	    	if (event.flight_number) {
	    		string += '<strong>Flight Number</strong><br>' + event.flight_number + '<br>';
	    	};

	    	string += '<strong>Description</strong><br>' + event.description + '<br>';

      	//element.attr('title', string);
      	element.popover({
      		html: true,
      		content: string,
      		trigger: 'hover',
      		container: 'body',
      	});
    	}

	});
});