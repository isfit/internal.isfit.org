//Kind of generic functions for å legge til å fjerne rader. Fungerer bare for en spesifikk rad(tr) i et form (kan sikkert extendes til en plugin)
//For å få det til å fungere må kolonnene i første rad ha et data-number som settes til 1, og første rad ha en klasse addline

$('.addrow').click(function() {
		var row = $('tr.addline');
		$.each(row.children(), function(index, line) {
      var child = $(line).children('input').last();
      var id = parseInt($(line).children('input').last().data('number')) +1;
      $(line).append("<input id='voucher_"+child.attr('class')+""+id+"' class='"+child.attr('class')+"' data-number='"+id+"' type='text' name='voucher["+child.attr('class')+""+id+"]'>")
    });
});

$('.removerow').click(function() {
	var row = $('tr.addline');
		$.each(row.children(), function(index, line) {
      var child = $(line).children('input').last();
      var id = parseInt($(line).children('input').last().data('number'));
      if(id > 1) {
        child.remove();
      }
    });
});
