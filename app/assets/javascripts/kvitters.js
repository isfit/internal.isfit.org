if(!String.linkify) {
  String.prototype.linkify = function() {

    // http://, https://, ftp://
    var urlPattern = /\b(?:https?|ftp):\/\/[a-z0-9-+&@#\/%?=~_|!:,.;]*[a-z0-9-+&@#\/%=~_|]/gim;

    // www. sans http:// or https://
    var pseudoUrlPattern = /(^|[^\/])(www\.[\S]+(\b|$))/gim;

    // Email addresses *** here I've changed the expression ***
    var emailAddressPattern = /(([a-zA-Z0-9_\-\.]+)@[a-zA-Z_]+?(?:\.[a-zA-Z]{2,6}))+/gim;

    return this
    .replace(urlPattern, '<a target="_blank" href="$&">$&</a>')
    .replace(pseudoUrlPattern, '$1<a target="_blank" href="http://$2">$2</a>')
    .replace(emailAddressPattern, '<a target="_blank" href="mailto:$1">$1</a>');
  };
}

function format(s) {
  var sanitized = s.replace(/&(?!\w+([;\s]|$))/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
  var formatted = sanitized.replace(/(\s|^)@([A-Za-z0-9_]+)/g, "<a href='/users/username/$2'> @$2</a>");
  var linkified = formatted.linkify();
  return linkified;
}
function downloadKvitters() {
  $.getJSON('/kvitters/last.json', function(data) {

    $('#kvitter').empty();
    $('#kvitter').append('<h1 rel="popover" data-original-title="Kvitter" data-content="Kvitter is the internal Twitter of ISFiT. Write something inspiring, engaging, or simply informing, and share it with the world!">Kvitter</span>');
    $('#kvitter').append('<form name="kvitter" id="kvitter-form" action="kvitters/create.json" method="post"><textarea rows="2" style="width: 100%;"  name="message" placeholder="Si noe inspirerende..."></textarea><input type="submit" class="btn btn-small" value="Kvitr!" /></form>');
    $('#kvitter').append('<ul id="kvitter-posts"></ul>');
    $('[rel=popover]').popover({
      offset: 10
    });

    data.forEach(function(item){
      appendKvitter(item);
    });
    $('#kvitter-form').submit(function(e) {
      e.preventDefault();
      $('#kvitter-form > input').disabled = true;
      $.ajax({
        type: 'POST',
        url: "/kvitters/create.json",
        data: $('#kvitter-form').serialize(),
        dataType: 'json',
        success: function(data) {
          prependKvitter(data);
          $('#kvitter-form')[0].reset();
          $('#kvitter-form > input').disabled = false;
        }
      });
    })


  });
}

function refreshKvitters() {
  $.getJSON('/kvitters/last.json', function(data) {

    $('#kvitter-posts').empty();
    data.forEach(function(item){
      appendKvitter(item);
    });
  });
}

function appendKvitter(kvitt) {
  $('#kvitter-posts').append('<li id="kvitter-"' + kvitt.id + '"><a href="/users/'+ kvitt.user_id + '">@' + kvitt.username + '</a> ' + format(kvitt.message) + '<br><span class="small">'+ humanized_time_span(kvitt.created_at) + '</span></li>');
}

function prependKvitter(kvitt) {
  $('#kvitter-posts').prepend('<li id="kvitter-"' + kvitt.id + '"><a href="/users/'+ kvitt.user_id + '">@' + kvitt.username + '</a> ' + format(kvitt.message) + '<br><span class="small">'+ humanized_time_span(kvitt.created_at) + '</span></li>');
}

jQuery.fn.exists = function(){return jQuery(this).length>0;}

$(function() {
  if ($('#kvitter').exists()) {
    downloadKvitters();
    setInterval(refreshKvitters,20*1000);
  }
})
