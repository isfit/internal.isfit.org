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
		timeFormat: 'H(:mm)',
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
        	element.attr('title', event.description);
        	//element.tooltip({
            //	content: event.description
        	//});
    	}

	});
});