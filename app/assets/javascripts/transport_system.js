$("#todo_table").tablesorter(); 

// Toggle and save a Drive objects completed boolean
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