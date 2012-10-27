$(function() {
  $("#new_drive").hide();
  $("#drives_table").hide();

  //Check to see if a given start and time, and date has any available cars and drivers
	$("#time_query").submit(function(event){
		event.preventDefault();
		url = $(this).attr( 'action' );

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
  
  // Parse JSON object to display available drivers, cars and such at a given time
  function updateDriveForm (data) {
    $("#drives_found").empty();


    //For some reason we must parse a json obj to a json object.. WAT?
    var j_cars = JSON.parse(data.cars),
        j_drivers = JSON.parse(data.drivers);

    if (data.drives) {
      var j_drives = JSON.parse(data.drives);
      $("#drives_found").append('<h3>Fant '+j_drives.length+' eksisterende oppdrag</h3>');

      $("#drives_table").show();
      $("#drives_table tbody").empty();
      for (var i = 0; i<j_drives.length; i++) { 
        $("#drives_table tbody").append("<tr>\
          <td>"+j_drives[i].id+"</td>\
            <td>"+j_drives[i].car_id+"</td>\
            <td>"+j_drives[i].driver_id+"</td>\
            <td>"+j_drives[i].description+"</td>\
            <td>"+j_drives[i].comment+"</td>\
            <td>"+j_drives[i].start_time+"</td>\
            <td>"+j_drives[i].end_time+"</td>\
            <td>"+j_drives[i].completed+"</td>\
          </tr>")
      }
    }
    else {
        $("#drives_found").append('<h3>Fant ingen eksisterende oppdrag ved gitt tid</h3>');
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
});