$(document).ready(function() {
	hideObjects();
	checkObjectsVisibility();
});

$(window).scroll( function() {
	hideObjects();
	checkObjectsVisibility();
});

function hideObjects() {
	$('.fadeInUp-scroll').css({
		'opacity': 0,
		'transform': 'translateY(100px)'
	});
}

function checkObjectsVisibility() {
	$('.fadeInUp-scroll').each( function(i) {
		var objectTop = $(this).offset().top;
		var windowBottom = $(window).scrollTop() + $(window).outerHeight();

		if( windowBottom > objectTop - 100){
			$(this).addClass('visible');
		} else {
			$(this).removeClass('visible');
		}
	});
}