var Main = (function(){
  return {

    init : function(){
      Main.mainSlide();
			Main.noticeSlider();
			Main.googleMap();
			Main.modalControl();

      var cachedWidth = $(window).width();
      $(window).resize(function(){
        var newWidth = $(window).width();
        if(newWidth !== cachedWidth){

        }
      })
    },

    mainSlide: function(){
      $('#slider1').owlCarousel({
        loop:true,
        nav:true,
        items:1
      });	
    },
		noticeSlider: function(){
			if($('.noticeSlider').length){
				actionNoticeSlider();
			};
			$('.contactLink1').on('click', function(){
				var cachedWidth = $(window).width();
				
				setTimeout(actionNoticeSlider, 200);
				$('.noticeSlider.flexslider .slides > li').css({width: cachedWidth});
			});

		},
		googleMap: function(){
			if($('.gmaps').length){
				initializeGoogleMap();
			};
			$('.contactLink2').on('click', function(){
				setTimeout(initializeGoogleMap, 200);
			})
		},
		modalControl: function(){
			$("#noticeModal").on("show", function () {
				$("body").addClass("modal-open");
			}).on("hidden", function () {
				$("body").removeClass("modal-open")
			});
		}
	}

})();

function actionNoticeSlider(){
  $('.noticeSlider').flexslider({
		animation: 'slide',
		controlNav: false,
		prevText: '',
		nextText: ''
	})
}




$(function(){
  Main.init();
});