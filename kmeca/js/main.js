// 스크롤 이동
$(function() {
   $('body').on('click', '.nav-content li a', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

$(window).scroll(function() {
	// 영역별 Menu 활성화
	var scrollDistance = $(window).scrollTop();
	$('.scroll').each(function(i) {
		if ($(this).position().top-100 <= scrollDistance) {
			$('.nav-content li a.on').removeClass('on');
			$('.nav-content li a').eq(i).addClass('on');
		}
	});
	// Header, Class 추가
	var startScroll = $(this).scrollTop();
	if(startScroll > 90){
		$('.header').addClass('header-opacity');
	}else{
		$('.header').removeClass('header-opacity');
	}
});