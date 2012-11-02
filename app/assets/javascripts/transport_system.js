$(function() {

  //Hide tables and feedback in /transport/
  $("#new_drive").hide();
  $("#drives_table").hide();
  $("#date_time_feedback").hide();

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
    var button = $(this);

    $.ajax({
      type: 'POST',
      url: '/transport/todo/update_completed',
      data: {id: button.attr('id')}  ,
      success: function(data) {
        if (button.hasClass("btn-success")) {
          button.removeClass("btn-success");
          button.addClass("btn-danger");
        }
        else {
          button.removeClass("btn-danger");
          button.addClass("btn-success");
        }
      }
    });
  });
  //Submit the newly edit comment.
  $("#comment_form").live("submit", function(event) {
    var form = $(this);
    event.preventDefault();
    $.ajax({
      type: 'POST',
      url: '/transport/todo/save_comment',
      data: form.serialize(),
      success: function(data) { 

        // Add the newly saved text back into closed format.
        //Cannot use click trigger on .edit_comment (its a class), but same func.
        var text = form.find("#comment_textarea").val();
        var comment_text = form.parent();
        comment_text.parent().addClass("closed");
        comment_text.empty();
        comment_text.text(text);

        //Bootstap success notification
        $("#drives_title").parent().prepend('\
          <div class="alert alert-success">\
            <button type="button" class="close" data-dismiss="alert">×</button>\
          Kommentar lagret </div>');
      }
    });
    return false;

  });

  //Comment on a drive mission in todo/you and todo/all.
  $(".edit_comment").click(function() {
    var comment = $(this).parent(),
        comment_text = comment.find("#comment_text"),
        comment_text_content = comment_text.text(),
        comment_id = $(this).parent().attr('id');

    if(comment.hasClass("closed")) {
      comment.removeClass("closed");
      comment_text.empty();

      var form = $('<form id="comment_form"></form>');
      form.append('<textarea name="drive[comment]" rows="3" id="comment_textarea">'+comment_text_content+'</textarea>');
      form.append('<input type="hidden" name="drive[id]" value="'+comment_id+'">');
      form.append('<br> <input id="submit_comment" type="submit" value="Lagre">');

      comment_text.append(form);
      $(this).text("[Angre]");

    }
    else {
      var textarea = comment_text.find("textarea").text();
      comment_text.empty();
      comment_text.text(comment_text_content);
      comment.addClass("closed");
      $(this).text("[Endre]");
    }

  });


  //Moves the screen to lastest/next drive mission in todo/you and todo/all
  function moveToNext() {
    var current_date = new Date();
    var next_mission_date = new Date(2022,22,22);
    var moveTo = -1;
    $("#todo_table").find(".drive_date").each(function() {
      var d = new Date($(this).text().split('-'));
      if(d < next_mission_date && (d > current_date)) {
        next_mission_date = d;
        moveTo = $(this).parent();
      }

    });

    if(moveTo == -1) {
      moveTo = $("#todo_table tbody tr:last");
    }
    moveTo.attr('style', 'background: yellow');
    var container = $('#todo_table'),
        scrollTo = moveTo;

    //container.scrollTop(scrollTo.offset().top - container.offset().top + container.scrollTop());
  }
    //moveToNext();

  
  // Parse JSON object to display available drivers, cars and such at a given time
  function updateDriveForm (data) {
    $("#date_time_feedback").show();
    $("#drives_table tbody").empty();
    $("#drives_table").hide();

    //For some reason we must parse a json obj to a json object.. WAT?
    var j_cars = JSON.parse(data.cars),
        j_drivers = JSON.parse(data.drivers);


    if (data.drives) {
      var j_drives = JSON.parse(data.drives);
      var j_drives_mod = JSON.parse(data.drives_mod);
      
      //Alert no of current drive missions at given time.
      $("#transport_search").parent().prepend('\
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
        $("#transport_search").parent().prepend('\
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
      $("#drive_driver_id").append('<option value='+j_drivers[i].id+'>'+j_drivers[i].given_name+'</option>');
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
  $(".delete_car").click(function(event) {
    if(confirm("Er du sikker på at du vil slette bilen?\
     \nAlle tidligere og fremtidlige oppdrag med denne bilen vil bli merket som [Slettet]")) {
    }
    else {
        event.preventDefault();
    }
  });
});