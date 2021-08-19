var Common = (function(){
	var headerScroll = false;
	var oldDeviceCheck;

	return {
		init : function(){
			Common.hashCheck();
			Common.preLoader();
			Common.deviceCheck();
			Common.mobileMenu();
			Common.scrollMenu();
			Common.smoothScroll();
			Common.animateScript();
			
			var cachedWidth = $(window).width();
			$(window).resize(function(){
				var newWidth = $(window).width();
				if(newWidth !== cachedWidth){
					//DO RESIZE HERE
					Common.deviceCheck();
					Common.mobileMenuReset();
					cachedWidth = newWidth;
				}
			});
		},
		hashCheck : function(){
			var target = location.hash.replace('#','');
			if(target=='') return;
			var target1 = target.substring(0, target.length-1);

			var num = target.substring(target.length - 1, target.length)-1;

			if (target.length) {
				
				setTimeout(function(){
					jQuery('html,body').animate({
						scrollTop: jQuery("#"+target1).offset().top
					}, 400, function(){
						jQuery("#"+target1).find(".nav-tabs>li:eq("+num+")").find('a').trigger('click');
						$('#simple-menu').removeClass("is-active");
						TweenMax.to($(".mgnb_wrap"), 0.5,{autoAlpha:0,ease: Power3.easeOut});
						$('.mgnb_wrap').stop().slideUp(300);
					});
				}, 500)
			}
		},
		preLoader: function(){
			imageSources = []
			$('img').each(function() {
				var sources = $(this).attr('src');
				imageSources.push(sources);
			});
			if($(imageSources).load()){
				$('.pre-loader').fadeOut('slow');
			}
		},
		mobileMenuReset : function(){
			$("#simple-menu").removeClass("is-active");
			TweenMax.to($(".mgnb_wrap"), 0.5,{autoAlpha:0,ease: Power3.easeOut});
			$('.mgnb_wrap').stop().slideUp(300);
		},

		scrollMenu: function(){
			var num = 100;			
			$(window).scroll(function () {
				if ($(window).scrollTop() > num) {
					$('.header').addClass('scrolled');
				} else {
					$('.header').removeClass('scrolled');
				}
			});
		},

		smoothScroll: function() {
			// Smooth Scrolling
			$('a[href*=#].smooth').click(function() {
				
				if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
					
					var target = $(this.hash);
					target = (target.length) ? target : $('[name=' + this.hash.slice(1) + ']');
					
					if (target.length) {
						$('html,body').animate({
							scrollTop: target.offset().top
						}, 1000);
						$('#simple-menu').removeClass("is-active");
						TweenMax.to($(".mgnb_wrap"), 0.5,{autoAlpha:0,ease: Power3.easeOut});
						$('.mgnb_wrap').stop().slideUp(300);
						return false;
					}
				}
			});
			$('a[href*=#].smooth_li').click(function(e) {
				var target0 = this.hash;
				var target = this.hash.replace('#','');
				var target1 = target.substring(0, target.length-1);

				var num = $(this).parent().index();

				if (target.length) {

					setTimeout(function(){
						$('html,body').animate({
							scrollTop: $("#"+target1).offset().top
						}, 400, function(){
							if(target1=='contact'){
								if($('.noticeSlider').length){
									actionNoticeSlider();
								};
								if($('.gmaps').length){
									initializeGoogleMap();
								}
							}
							$("#"+target1).find(".nav-tabs>li:eq("+num+")").find('a').trigger('click');
							$('#simple-menu').removeClass("is-active");
								TweenMax.to($(".mgnb_wrap"), 0.5,{autoAlpha:0,ease: Power3.easeOut});
								$('.mgnb_wrap').stop().slideUp(300);
						});
					}, 500)
				}
			});
		},

		animateScript: function() {
			$('.scrollpoint.sp-effect1').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeInLeft');},{offset:'100%'});
			$('.scrollpoint.sp-effect2').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeInRight');},{offset:'100%'});
			$('.scrollpoint.sp-effect3').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeInDown');},{offset:'100%'});
			$('.scrollpoint.sp-effect4').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeIn');},{offset:'100%'});
			$('.scrollpoint.sp-effect5').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeInUp');},{offset:'100%'});
		},

		deviceCheck : function(){
			var DeviceCheck;
			var w = $(window).width();
			var h = $(window).height();

			if(w < 768){
				DeviceCheck = "M";
			}else if(w > 767 && w < 992){
				DeviceCheck = "T";
			}else if(w > 991){
				DeviceCheck = "W";
			}

			if(DeviceCheck != oldDeviceCheck){
				oldDeviceCheck = DeviceCheck;
				
				$.each($(".mgnb > li"),function(i,val){
					$(val).css("height",(oldDeviceCheck == "M") ? 40 : 120);
				});

				$('.mgnb_wrap').css("height",h);

				$("html").removeClass("device_W");
				$("html").removeClass("device_T");
				$("html").removeClass("device_M");
				$("html").addClass("device_"+oldDeviceCheck);
			}
		},

		mobileMenu : function(){
			$("#simple-menu").on("click",function(e){
				e.preventDefault();
				if($(this).hasClass("is-active")){
					$(this).removeClass("is-active");
					TweenMax.to($(".mgnb_wrap"), 0.5,{autoAlpha:0,ease: Power3.easeOut});
					$('.mgnb_wrap').stop().slideUp(300);
				}else{
					$(this).addClass("is-active");
					$('.mgnb_wrap').stop().slideDown(300);
					TweenMax.to($(".mgnb_wrap"), 0.5,{autoAlpha:1,ease: Power3.easeOut});
				}
		   });


		}

		
	}
})();
function initializeGoogleMap(){
	var latlng = new google.maps.LatLng(37.48141722918277,126.88038536308021);
	var myOptions = {
		 zoom: 15,
		 center: latlng,
		 mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
	var myMarker = new google.maps.Marker({position: latlng,animation: google.maps.Animation.DROP,map: map});
}
$(function(){
	Common.init();
	$('body').scrollspy({ target: '.gnb_wrap' })
});

