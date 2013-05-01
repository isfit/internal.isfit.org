function setEditableFields(url, token, users, status_options) {
  setHeight();
  setHover();
  edit();
  description(url, token);
  proofread(url, token);
  number(url, token);
  owner(url, token, users);
  status(url, token, status_options);
}

function setHeight() {
  $('div.editable.set-height').each(function(){
    var $div = $(this);

    $div.height($div.closest('td').height() * 0.8);
  });
}

function setHover() {
  $('.editable').hover(function() {
    $(this).css(
      'background',
      'transparent url("assets/pencil_go.png") no-repeat right bottom');
  }, function() {
    $(this).css('background', '');
  });
  $('.layout-jobs .editable').closest('td').hover(function() {
    $(this).css('border', '1px dotted');
  }, function() {
    $(this).css('border', '');
  });
}

function autoHeight() {
  $(this).height('auto');
}

function edit(url) {
  $('.edit').editable(url);
}

function onChanges() {
  $('.descript').toggleClass('span3 span8');
  $('.editable.textarea').toggleClass('description');
  $('.layout-jobs .hideable').toggle();
}

function description(url, token) {
  $('.editable.description').editable(url, {
    type      : 'textarea',
    submit    : 'OK',
    tooltip   : 'Click to edit...',
    height    : "75px",
    onedit    : onChanges,
    oncancel  : onChanges,
    onsubmit  : onChanges,
    onreset   : onChanges,
    onerror   : onChanges,
    submitdata: {
      type               : 'description',
      authenticity_token : token
    },
  });
}

function proofread(url, token) {
  $('.editable.proofread').editable(url, {
    submit : 'OK',
    placeholder: 'Not set',
    onedit: autoHeight,
    submitdata: {
      type: 'proofread',
      authenticity_token: token
    },
  });
}

function number(url, token) {
  $('.editable.number').editable(url, {
    submit : 'OK',
    placeholder: 'Not set',
    onedit: autoHeight,
    submitdata: {
      type: 'number',
      authenticity_token: token
    },
  });
}

function styleRemover() {
  var outerParent = $(this).parent().parent();
  outerParent.removeAttr('style');
}

function owner(url, token, users) {
  $('.editable.owner').editable(url, {
    data   : users,
    type   : 'select',
    submit : 'OK',
    onedit : autoHeight,
    cancel : 'Canc',
    onsubmit: styleRemover,
    submitdata: {
      type: 'owner',
      authenticity_token: token
    },
  });
}

function statusRemover (index, css) {
  return (css.match (/\bstatus_\S+/g) || []).join(' ');
}

function status(url, token, status_options) {
  $('.editable.status').editable(url, {
    data   : status_options,
    type   : 'select',
    submit : 'OK',
    onsubmit: function() {
      var outerParent = $(this).parent().parent();
      outerParent.removeClass(statusRemover);
    },
    submitdata: {
      type: 'status',
      authenticity_token: token
    },
  });
}
