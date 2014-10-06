function countdown(){
	var oneDay = 24*60*60*1000; // hours*minutes*seconds*milliseconds
	var today = new Date();
	var festivalDate = new Date('2015.02.05');

	var diffDays = Math.ceil(Math.abs((today.getTime()-festivalDate.getTime())/(oneDay)));
	return diffDays;
}

$(document).ready(function() {
	if ($('p.festival-countdown').length != 0) {
		$('p.festival-countdown').html(countdown());
	}
});