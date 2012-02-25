// Initialize the jQuery File Upload widget:

$('#spp_fileupload').fileupload({
  dataType: 'json',
  url: $('.file_upload').attr('action'),
  add: function (e, data) {
    data.submit();
  },
  dropzone: $("form.file_upload"),
  done: function (e, data) {
    str = "/system/original_pictures/"+data.result.photo.id+"/cropable/"+data.result.photo.original_picture_file_name
    $("#img1").html("<img src='"+str+"' id='spp_front_large' />");
    $("#img2").html("<img src='"+str+"' id='spp_front_small' />");
    $("#img3").html("<img src='"+str+"' id='spp_article' />");
    $("#spp_article_photo_id").val(data.result.photo.id);
    addCropping(data.result.ratio);
  }
});
$("button.dyntabs").click(function() {
  $("button").removeClass("btn-primary");
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

function addCropping(ratio) {

$('#spp_front_large').imgAreaSelect({ 
  minWidth: 620, 
  minHeight: 365,
  aspectRatio: '1.69:1',  
  handles: true, 
  onSelectEnd: function (img, selection) { 
    $('#x1').val(Math.round(selection.x1*ratio)); 
    $('#y1').val(Math.round(selection.y1*ratio)); 
    $('#x2').val(Math.round(selection.x2*ratio)); 
    $('#y2').val(Math.round(selection.y2*ratio)); 
    } 
});
$('#spp_front_small').imgAreaSelect({ 
  minWidth: 220, 
  minHeight: 131,
  aspectRatio: '1.68:1',  
  handles: true, 
  onSelectEnd: function (img, selection) { 
    $('#x1_1').val(Math.round(selection.x1*ratio)); 
    $('#y1_1').val(Math.round(selection.y1*ratio)); 
    $('#x2_1').val(Math.round(selection.x2*ratio)); 
    $('#y2_1').val(Math.round(selection.y2*ratio)); 
    } 
});
$('#spp_article').imgAreaSelect({ 
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
