// Initialize the jQuery File Upload widget:

$('#frontend_fileupload').fileupload({
  dataType: 'json',
  url: $('.file_upload').attr('action'),
  add: function (e, data) {
    data.submit();
  },
  dropzone: $("form.file_upload"),
  done: function (e, data) {
    str = "/system/original_pictures/"+data.result.photo.id+"/cropable/"+data.result.photo.original_picture_file_name
    $("#img1").html("<img src='"+str+"' id='frontend_front_large' />");
    $("#img2").html("<img src='"+str+"' id='frontend_front_small' />");
    $("#img3").html("<img src='"+str+"' id='frontend_article_img' />");
    $("#frontend_article_photo_id").val(data.result.photo.id);
    frontendAddCropping(data.result.ratio);
  }
});
$("button.article").click(function() {
  $("button.article").removeClass("btn-primary");
  $(this).addClass("btn-primary");
  $(".hidable").hide();
  $(".imgareaselect-outer").hide();
  $(".imgareaselect-border1").hide();
  $(".imgareaselect-border2").hide();
  $(".imgareaselect-border3").hide();
  $(".imgareaselect-border4").hide();
  $(".imgareaselect-selection").hide();
  $(".imgareaselect-handle").hide();

  if ($(this).attr("data-page") === "images"){
    $(".imgareaselect-outer").show();
    $(".imgareaselect-border1").show();
    $(".imgareaselect-border2").show();
    $(".imgareaselect-border3").show();
    $(".imgareaselect-border4").show();
    $(".imgareaselect-selection").hide();
    $(".imgareaselect-handle").hide();
  }


  $("#"+$(this).attr("data-page")).show();
});
$(".hidable").hide();
$("#images").show();

function frontendAddCropping(ratio) {

  $('#frontend_front_large').imgAreaSelect({ 
    minWidth: 530, 
    minHeight: 196,
    aspectRatio: '2.70:1',  
    handles: true, 
    onSelectEnd: function (img, selection) { 
      $('#x1').val(Math.round(selection.x1*ratio)); 
      $('#y1').val(Math.round(selection.y1*ratio)); 
      $('#x2').val(Math.round(selection.x2*ratio)); 
      $('#y2').val(Math.round(selection.y2*ratio)); 
    } 
  });
  $('#frontend_front_small').imgAreaSelect({ 
    minWidth: 250, 
    minHeight: 120,
    aspectRatio: '2.08:1',  
    handles: true, 
    onSelectEnd: function (img, selection) { 
      $('#x1_1').val(Math.round(selection.x1*ratio)); 
      $('#y1_1').val(Math.round(selection.y1*ratio)); 
      $('#x2_1').val(Math.round(selection.x2*ratio)); 
      $('#y2_1').val(Math.round(selection.y2*ratio)); 
    } 
  });
  $('#frontend_article_img').imgAreaSelect({ 
    minWidth: 447, 
    minHeight: 346,
    aspectRatio: '1.29:1',  
    handles: true, 
    onSelectEnd: function (img, selection) { 
      $('#x1_2').val(Math.round(selection.x1*ratio)); 
      $('#y1_2').val(Math.round(selection.y1*ratio)); 
      $('#x2_2').val(Math.round(selection.x2*ratio)); 
      $('#y2_2').val(Math.round(selection.y2*ratio)); 
    } 
  });
}
