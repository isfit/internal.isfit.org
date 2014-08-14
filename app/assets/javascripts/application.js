// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ./jquery/jquery.fileupload
//= require ./jquery/jquery.fileupload-ui.js
//= require_tree ./jquery
//= require bootstrap-datepicker
//= require private_pub
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
  $('.datetimepicker').datetimepicker();
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

// Twitter integration
function getTwitterFeed(username) {
  $.getJSON('https://api.twitter.com/1/statuses/user_timeline.json?id='+username+'&count=4&callback=?', function(data) {
    $('#twitter-header').append('<h3><a target="_blank" href="http://www.twitter.com/' + username + '"><img src="' + data[0].user.profile_image_url_https + '" style="float: right;"/> @' + username + '</a></h3>');
    $('#twitter-header').append('<p><em>' + data[0].user.description + '</em></p>');
    data.forEach(function(item){
      $('#twitter-statuses').append('<div id="status-' + item.id + '"></div>');
      $('#status-'+item.id).append('<blockquote><p style="font-size: 13px;">' + item.text.linkify() + '</p><small>' + item.user.name + ' @ ' + item.user.location + '</small>');
    });
  });
};

$(function() {
  if ($('#twitter-button').exists()) {
    getTwitterFeed($('#twitter-button').data("username"));
  }
});


//User search

function getUsersJSON() {
  $.getJSON('/users.json', function(data) {
    var userArray = [];
    data.forEach(function(user) {
      var searchString = user.given_name + " " + user.family_name + " - @" + user.username;
      userArray.push(searchString);
    });
    //console.log(JSON.stringify(userArray));
    $('#user-search').attr('data-source', JSON.stringify(userArray));
  });
}
function select_user(){
    var searchString = $('#user-search').val();
    var formattedSearch = searchString.split('@');
    formattedSearch = formattedSearch[formattedSearch.length-1]
    window.location.href = "/users/username/" + formattedSearch
    return false;
}
$(function() {
  getUsersJSON();
  
  $('#user-search-form').submit(function() {
    select_user();
    return false;
  });

});

$('#user-search').change(function() {
  $('#user-search-form').submit();
});
