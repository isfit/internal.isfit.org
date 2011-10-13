// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require_self

$(function() {
  $('.sortable').tablesorter({ sortList: [[1,0]] });

  $('.chosen-select').chosen();

  $('[rel=popover]').popover({
    offset: 10
  }).click(function(e) { 
    e.preventDefault()
  });
  //$('.datetimepicker').datetimepicker();
});
$(function () {
  $('#main').imgAreaSelect({
    minWidth: 531,
    minHeight: 196,
    aspectRatio: '2.71:1',
    handles: true ,
    onSelectEnd: function (img, selection) {
      $('input[name=x1]').val(selection.x1);
      $('input[name=y1]').val(selection.y1);
      $('input[name=x2]').val(selection.x2);
      $('input[name=y2]').val(selection.y2);
    } 
  });
  $('#half').imgAreaSelect({
    minWidth: 253,
    minHeight: 136,
    aspectRatio: '1.86:1',
    handles: true ,
    onSelectEnd: function (img, selection) { 
      $('input[name=x1_1]').val(selection.x1);
      $('input[name=y1_1]').val(selection.y1);
      $('input[name=x2_1]').val(selection.x2);
      $('input[name=y2_1]').val(selection.y2);
    } 
  });
  $('#photo-article').imgAreaSelect({
    minWidth: 531,
    minHeight: 250,
    aspectRatio: '2.12:1', 
    handles: true ,
    onSelectEnd: function (img, selection) {
      $('input[name=x1_2]').val(selection.x1);
      $('input[name=y1_2]').val(selection.y1);
      $('input[name=x2_2]').val(selection.x2);
      $('input[name=y2_2]').val(selection.y2);
    } 
  });
});

