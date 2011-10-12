$('#half').imgAreaSelect({ minWidth: 260, minHeight: 340,aspectRatio: '0.76:1',  handles: true , onSelectEnd: function (img, selection) { $('input[name=x1_1]').val(selection.x1); $('input[name=y1_1]').val(selection.y1); $('input[name=x2_1]').val(selection.x2); $('input[name=y2_1]').val(selection.y2); } 
});
$('#spp_one_third').imgAreaSelect({ minWidth: 210, minHeight: 310,aspectRatio: '0.72:1',  handles: true , onSelectEnd: function (img, selection) { $('input[name=x1_2]').val(selection.x1); $('input[name=y1_2]').val(selection.y1); $('input[name=x2_2]').val(selection.x2); $('input[name=y2_2]').val(selection.y2); } 
});
$('#spp_full').imgAreaSelect({ minWidth: 700, minHeight: 320,aspectRatio: '2.19:1',  handles: true , onSelectEnd: function (img, selection) { $('input[name=x1_3]').val(selection.x1); $('input[name=y1_3]').val(selection.y1); $('input[name=x2_3]').val(selection.x2); $('input[name=y2_3]').val(selection.y2); } 
});

$("a[rel^='prettyPhoto']").prettyPhoto({social_tools: ''}); 
