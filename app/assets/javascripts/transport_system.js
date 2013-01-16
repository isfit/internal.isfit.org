$(function() {

  //Hide tables and feedback in /transport/
  $("#new_drive").hide();
  $("#drives_table").hide();
  $("#date_time_feedback").hide();
  $('.example').tooltip({ 
        selector: 'A'
    });
  $("#todo_table").tablesorter(); 


  //Hide tables in admin

  //Check to see if a given start and time, and date has any available cars and drivers
	$("#time_query").submit(function(event){
		event.preventDefault();
		var url = $(this).attr( 'action' );

		$.ajax({
           type: "POST",
           url: url,
           data: $(this).serialize(), // serializes the form's elements.
           dataType: "json",
           success: function(data)
           {
              $("#new_drive").show();
           		//$('# test_reload').load('transport/_form')
               updateDriveForm(data);
           },
           error: function (xhr, ajaxOptions, thrownError) {
            alert(xhr.status);
            alert(thrownError);
          }

         
         });
      return false;
	   });

  $("#shift_form").submit(function(event) {
    event.preventDefault();
    var url = $(this).attr('action');
    $.ajax({
      type: "POST",
      url: url,
      data: $(this).serialize(),
      success: function(date) {
        alert("SUCCESS");
      },
      error: function(xhr, ajaxOptions, thrownError) {
        alert("error");
      }
    });
  });

  // Toggle and save a Drive objects completed boolean in /todo
  $("#todo_table tbody td button").click(function() {
    var button = $(this),
    url = button.attr('id');

    $.ajax({
      type: 'PUT',
      url: url,
      success: function(data) {
        button.empty();
        if (button.hasClass("btn-success")) {
          button.removeClass("btn-success");
          button.addClass("btn-danger");
          button.append('<i class="icon-remove">');
        }
        else {
          button.removeClass("btn-danger");
          button.addClass("btn-success");
          button.append('<i class="icon-ok">');

        }
      }
    });
  });

  $(".expand").click(function() {
    var d = $(this);
    if(d.hasClass("fall")) {
      d.removeClass("fall");
      $(this).find(".minimize").addClass("expand_y");
    }
    else {
      d.addClass("fall")
      $(this).find(".minimize").removeClass("expand_y");

    }
  });

  
  // Parse JSON object to display available drivers, cars and such at a given time
  function updateDriveForm (data) {
    $("#date_time_feedback").show();
    $("#drives_table tbody").empty();
    $("#drives_table").hide();

    //For some reason we must parse a json obj to a json object.. WAT?
    var j_cars = JSON.parse(data.cars),
        j_drivers = JSON.parse(data.drivers);

    //Remove any previous notification (or else they stack up)
    $("#transport_notification").empty();
    if (data.drives) {
      var j_drives = JSON.parse(data.drives);
      var j_drives_mod = JSON.parse(data.drives_mod);
      

      //Alert no of current drive missions at given time.
      $("#transport_notification").append('\
          <div class="alert alert-info">\
            <button type="button" class="close" data-dismiss="alert">x</button>\
          Fant '+j_drives.length+' eksisterende oppdrag på gitt tidspunkt. </div>');

      //Show the table of drives.      
      $("#drives_table").show();

      for (var i = 0; i<j_drives_mod.length; i++) {
        $("#drives_table tbody").append('<tr>');
        for(var j = 0; j < j_drives_mod[i].length; j++) {
          $("#drives_table tbody").append('<td>'+j_drives_mod[i][j]+'</td>');
        }
        $("#drives_table tbody").append('</tr>');
      }
    }
    else {
        $("#transport_notification").append('\
          <div class="alert alert-success">\
            <button type="button" class="close" data-dismiss="alert">x</button>\
         Fant ingen eksisterende oppdrag på gitt tidspunkt </div>');
      }
    
    //Select Cars
    $("#drive_car_id").empty();
    for (var i = 0; i<j_cars.length; i++) {
      $("#drive_car_id").append('<option value='+j_cars[i].id+'>'+j_cars[i].name+' - '+j_cars[i].description+' - '+j_cars[i].seats+' seter</option>');
    }

    //Select Drivers
    $("#drive_driver_id").empty()
    for (var i = 0; i<j_drivers.length; i++) {
      $("#drive_driver_id").append('<option value='+j_drivers[i].id+'>'+j_drivers[i].given_name+' - ('+j_drivers[i].drives_count+')</option>');
    }

    //Time and date
    var start_time = $("#start_time").attr('value'),
        end_time = $("#end_time").attr('value'),
        date = $("#date").attr('value');
    
    $("#fra_kl").empty();
    $("#fra_kl").append(start_time);
    $("#drive_start_time").val(date+" "+start_time+":00");

    $("#til_kl").empty();
    $("#til_kl").append(end_time);
    $("#drive_end_time").val(date+" "+end_time+":00");

    $("#dato").empty();    
    $("#dato").append(date);
  }

  //Removal of car functionality for admins.
  $(".delete_car").click(function(event) {
    if(confirm("Er du sikker på at du vil slette bilen?\
     \nAlle tidligere og fremtidlige oppdrag med denne bilen vil bli merket som [Slettet]")) {
    }
    else {
        event.preventDefault();
    }
  });


});