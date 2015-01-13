$(document).ready(function() {
  if ($('#kvitter-index').length) {
    $('.kvitter-message').each(function(index) {
      $(this).html(format($(this).text()));
    });

    $('.kvitter-user').each(function(index) {
      $(this).html(format($(this).text()));
    });
  }

});

if(!String.linkify) {
  String.prototype.linkify = function() {

    // http://, https://, ftp://
    var urlPattern = /\b(?:https?|ftp):\/\/[a-z0-9-+&@#\/%?=~_|!:,.;]*[a-z0-9-+&@#\/%=~_|]/gim;

    // www. sans http:// or https://
    var pseudoUrlPattern = /(^|[^\/])(www\.[\S]+(\b|$))/gim;

    // Email addresses *** here I've changed the expression ***
    var emailAddressPattern = /(([a-zA-Z0-9_\-\.]+)@[a-zA-Z_]+?(?:\.[a-zA-Z]{2,6}))+/gim;

    // #{word}
    var hashtagPattern = /#[\wæøåÆØÅ][\wæøåÆØÅ-]+(\b|$)/gim;

    var matchHashtag = this.match(hashtagPattern);
    if (matchHashtag != null) {
      for (var i = 0; i < matchHashtag.length; i++) {
        //console.log("Hashtag: " + matchHashtag[i]);
      }
    }

    return this
      .replace(urlPattern, '<a target="_blank" href="$&">$&</a>')
      .replace(pseudoUrlPattern, '$1<a target="_blank" href="http://$2">$2</a>')
      .replace(emailAddressPattern, '<a target="_blank" href="mailto:$1">$1</a>')
      .replace(hashtagPattern, '<a href="hashtags/$&">$&</a>')
      .replace(/\/#/g, '/%23'); // Replace /#<hashtag> with /%23<hashtag> because links cannot contain #(anchor)
  };
}

$(document).on('click', 'a.awesome',  function(event){
  event.preventDefault();
  var that = event.srcElement || event.target;
  var count_object = $.getJSON("/kvitters/" + $(that).attr("data-id") + "/awesome.json", function(data) {
    //console.log(data);
    $(that).next().text(data);
  });
});


function format(s) {
  var sanitized = s
                    .replace(/&(?!\w+([;\s]|$))/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;");
  var formatted = sanitized
                    .replace(/(\s|^)@([A-Za-z0-9_]+)/g, "<a href='/users/username/$2'> @$2</a>");
  var linkified = formatted.linkify();
  return linkified;
}
function downloadKvitters() {
  $.getJSON('/kvitters/last.json', function(data) {
    var kvitters = JSON.parse(data.kvitters);
    var user_given_name = JSON.parse(data.user_given_name);
    var button = JSON.parse(data.button);
    kvitter_time = new Date().getTime();
    $('#kvitter').empty();
    $('#kvitter').append('<h1 rel="popover" data-original-title="Kvitter" data-content="Kvitter is the internal Twitter of ISFiT. Write something inspiring, engaging, or simply informing, and share it with the world!">Kvitter</span>');
    $('#kvitter').append('<form name="kvitter" id="kvitter-form" action="kvitters/create.json" method="post"><textarea rows="3" style="width: 100%;"  name="message" placeholder="Si noe inspirerende, ' + user_given_name + '..."></textarea><input type="submit" class="btn btn-info" value="Kvitr!" />' + button + '</form>');
    $('#kvitter').append('<ul id="kvitter-posts" class="media-list"></ul>');
    $('#kvitter').append('<a href="/kvitters" class="btn btn-info btn-kvitter-see-more">Se flere</a>');
    $('[rel=popover]').popover({
      offset: 10
    });

    kvitters.forEach(function(kvitter){
      appendKvitter(kvitter);
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
  $.getJSON('/kvitters/last.json?time='+kvitter_time, function(data) {
    var kvitters = JSON.parse(data.kvitters);
    kvitters.forEach(function(kvitter){
      var el = $('#kvitter-'+kvitter.id);
      if (el.length == 1) {
        el.find('.count').html((kvitter.teller ? kvitter.teller : "0"));
      }
      else {
        prependKvitter(kvitter);
      }
    });
  });
}

function appendKvitter(kvitt) {
  //console.log(JSON.stringify(kvitt))
  $('#kvitter-posts').append(kvitterFormatting(kvitt));
}

function prependKvitter(kvitt) {
  $('#kvitter-posts').prepend(kvitterFormatting(kvitt));
}
function kvitterFormatting(kvitt) {

  var formatted = '' + '<li id="kvitter-'+kvitt.id+'" class="kvitter media">';

  if (kvitt.user_image !== null) {
    formatted = formatted +
      '<a class="pull-left" href="/users/'+ kvitt.user_id +'">' +
        '<img class="media-object" src="' + kvitt.user_image + '">' +
      '</a>';
  }
  formatted = formatted +
      '<div class="media-body">' +
        '<strong>' + kvitt.user_full_name + '</strong>' +
        '<br />' +
        format(kvitt.message) +
        '<br />'+
        '<span class="small">'+
          '<a href="/users/'+ kvitt.user_id + '">' +
            '@'+kvitt.username +
          '</a> ' +
          humanized_time_span(kvitt.created_at) +
        '</span>'+
        '<span class="pull-right"><strong>'+
          '<a href="#" class="awesome" data-id="'+kvitt.id+'"> \\o/ </a>'+
          '<span class="count"> ' +
            (kvitt.teller ? kvitt.teller : "0")+
          '</span></strong>'+
        '</span>'+
      '</div>' +
    '</li>';
  return formatted;
}

jQuery.fn.exists = function(){return jQuery(this).length>0;}

$(function() {
  if ($('#kvitter').exists()) {
    downloadKvitters();
    setInterval(refreshKvitters,20*1000);
  }
})
