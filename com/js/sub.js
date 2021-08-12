var Sub = (function(){
	return {
		init: function(){
			Sub.certModal();
			Sub.mapControl();
			Sub.shelfItemAlign();			
			Sub.catSlider();
			Sub.tvModal();			
			Sub.branchslider();
			Sub.faqList();
			Sub.spSlider();
			Sub.tvItemAlign();
			Sub.pressItemAlign();
			Sub.reviewItemAlign();
			var cachedWidth = $(window).width();
			$(window).resize(function(){
				var newWidth = $(window).width();
				if(newWidth !== cachedWidth){

					Sub.certModal();
					Sub.mapControl();
					Sub.shelfItemAlign();
					Sub.catSlider();
					Sub.tvModal();
					Sub.branchslider();
					Sub.spSlider();
					Sub.tvItemAlign();
					Sub.pressItemAlign();
					Sub.reviewItemAlign();
					cachedWidth = newWidth;
				}
			})
			
		},
		certModal: function(){
			$('body').on('click', '.certView', function(e){
				e.preventDefault();
			})
			$('#certModal').on('show.bs.modal', function (event) {
				var button = $(event.relatedTarget);
				var recipient = button.data('whatever');
				var modal = $(this);
				modal.find('.modal-body img.aligncenter').attr('src', recipient);
			}).on('hide.bs.modal', function (event) {
				var modal = $(this);
				modal.find('.modal-body img.aligncenter').attr('src', '');
			});
			
		},

		mapControl: function(){
			if($('#map_canvas').length){
				var latlng = new google.maps.LatLng(37.48141722918277,126.88038536308021);
				var myOptions = {
					zoom: 15,
					center: latlng,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				};
				var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
				var myMarker = new google.maps.Marker({position: latlng,animation: google.maps.Animation.DROP,map: map});
			}
		},

		topNavControl: function(){
			var iv;
			for (iv=0; iv < 6; iv++){
				if($('body').hasClass('sub0' + iv) == true){
					//alert('sub0' + iv)
					$('.su0' + iv).each(function(){
						$(this).addClass('active');
					})
				}
			};
		},
		
		shelfItemAlign:function(){
			$('body').on('click', '.shelf-tabs li a', function(){
				if($('.shelf-list').length){setTimeout(shelfList, 300);}
			})
			if($('.shelf-list').length){
				shelfList();
			}
		},
		
		

		catSlider: function(){
			if($('.catSlider').length){
				$('.catSlider').flexslider({
					animation: 'slide',
					directionNav: false
				})
			}
		},

		tvModal: function(){
			$('#tvModal').on('shown.bs.modal', function (event) {
				setTimeout(tvSlider, 200);
			});
			
		},
		
		

		branchslider: function(){
			if($('.branchslider').length){
				$('.branchslider').flexslider({
					animation: "slide",
					animationLoop: false,
					controlNav:false,
					itemWidth: 320,
					itemMargin: 20,
					minItems: 1,
					maxItems: 3,
					prevText:'',
					nextText:''
				});
			}
		},

		faqList: function(){
			$('#accordion .q').click(function(){
				$(this).parent('li').siblings('li').removeClass('active');
				$(this).parent('li').toggleClass('active');		
			})
		},

		spSlider: function(){
			if($('#spSlider').length){
				$('#spCarousel').flexslider({
					animation: "slide",
					controlNav: false,
					animationLoop: false,
					slideshow: false,
					itemWidth: 84,
					itemMargin: 20,
					asNavFor: '#spSlider',
					prevText: '',
					nextText: ''
				});

				$('#spSlider').flexslider({
					animation: "slide",
					controlNav: false,
					directionNav: false,
					animationLoop: false,
					slideshow: false,
					sync: "#spCarousel",
					prevText: '',
					nextText: ''
				});
			}
		},

		


		
		newsItemAlign:function(){
			if($('.news-list').length){
				$('.news-item').each(function(){
					var newsWidth = $(this).find('.news-inner').width();
					var newsHeight = $(this).find('.news-inner').height();
					var newsImgWidth = $(this).find('.news-img').width();
					var newsImgHeight = $(this).find('.news-img').height();
					var newsImgRt = newsImgHeight/newsImgWidth;
					$(this).find('.news-imgCont').css({height: .7067*newsWidth, 'overflow':'hidden'});
					$(this).find('.news-outer').css({width:newsWidth, height:newsHeight});
					if(newsImgRt > .7067){
						$(this).find('.news-img').css({width:newsWidth, height:newsWidth*newsImgRt, 'margin-top':-.5*newsWidth*(newsImgRt-.7067)});
					} else {
						$(this).find('.news-img').css({width:.7067*newsWidth/newsImgRt, height:.7067*newsWidth, 'margin-left':-.5*newsWidth*(.7067/newsImgRt -1)});
					}
				})
			}
		},
		videoItemAlign:function(){
			if($('.video-list').length){
				$('.video-item').each(function(){
					var videoWidth = $(this).find('.video-inner').width();
					var videoHeight = $(this).find('.video-inner').height();
					var videoImgWidth = $(this).find('.video-img').width();
					var videoImgHeight = $(this).find('.video-img').height();
					var videoImgRt = videoImgHeight/videoImgWidth;
					$(this).find('.video-imgCont iframe').css({height: .5625*videoWidth, 'overflow':'hidden'});
					$(this).find('.video-outer').css({width:videoWidth, height:.5625*videoWidth});

				})
			}
		},
		
		videoModal:function(){
			var trigger = $("body").find('[data-toggle="modal"]');
			trigger.click(function () {
				var theModal = $(this).data("target"),
				videoSRC = $(this).data("thevideo"),
				videoSRCorigin = "http://www.youtube.com/embed/" + videoSRC,
				videoSRCauto = "http://www.youtube.com/embed/" + videoSRC + "?autoplay=1&controls=0&rel=0&showinfo=0",
				videoSRCblank = "";
				//alert(videoSRC)
				$(theModal).find('iframe').attr('src', videoSRCauto);
				$(theModal).find('button.close').click(function () {
					$(theModal).find('iframe').attr('src', videoSRCblank);
				});
				$('.modal').click(function () {
					$(theModal + ' iframe').attr('src', videoSRCorigin);
				});
			});
		},
		
		recipeItemAlign:function(){
			if($('.recipe-list').length){
				$('.recipe-item').each(function(){
					var recipeWidth = $(this).find('.recipe-inner').width();
					var recipeHeight = $(this).find('.recipe-inner').height();
					var recipeImgWidth = $(this).find('.recipe-img').width();
					var recipeImgHeight = $(this).find('.recipe-img').height();
					var recipeImgRt = recipeImgHeight/recipeImgWidth;
					$(this).find('.recipe-imgCont').css({height: .7105*recipeWidth, 'overflow':'hidden'});
					$(this).find('.recipe-outer').css({width:recipeWidth, height:recipeHeight});
					if(recipeImgRt > .7105){
						$(this).find('.recipe-img').css({width:recipeWidth, height:recipeWidth*recipeImgRt, 'margin-top':-.5*recipeWidth*(recipeImgRt-.7105)});
					} else {
						$(this).find('.recipe-img').css({width:.7105*recipeWidth/recipeImgRt, height:.7105*recipeWidth, 'margin-left':-.5*recipeWidth*(.7105/recipeImgRt -1)});
					}
				})
			}
		},

		troubleRowAlign:function(){
			var windowWidth = $(window).width();
			if(windowWidth > 480){
				$('.troubleRow').each(function(){
					var troubleInnerHeight = $(this).children('.trouble-item:last-child').find('.trouble-inner').height();
					$(this).find('.trouble-inner').css({height:troubleInnerHeight});
				})
			}
		},
		tvItemAlign:function(){
			if($('.tv-list').length){
				$('.tv-item').each(function(){
					var tvWidth = $(this).find('.tv-inner').width();
					var tvHeight = $(this).find('.tv-inner').height();
					var tvImgWidth = $(this).find('.tv-img').width();
					var tvImgHeight = $(this).find('.tv-img').height();
					var tvImgRt = tvImgHeight/tvImgWidth;
					//console.log(tvWidth+'/'+tvHeight+'/'+tvImgWidth+'/'+tvImgHeight+'/'+tvImgRt)
					$(this).find('.tv-imgCont').css({height: .4473*tvWidth, 'overflow':'hidden'});
					$(this).find('.tv-imgLink').css({width:tvWidth, height:.4473*tvWidth});
					if(tvImgRt > .4473){
						$(this).find('.tv-img').css({width:tvWidth, height:tvWidth*tvImgRt, 'margin-top':-.5*tvWidth*(tvImgRt-.4473)});
					} else {
						$(this).find('.tv-img').css({width:.4473*tvWidth/tvImgRt, height:.4473*tvWidth, 'margin-left':-.5*tvWidth*(.4473/tvImgRt -1)});
					}
				})
			}
		},

		pressItemAlign:function(){
			if($('.press-list').length){
				$('.press-item').each(function(){
					var pressWidth = $(this).find('.press-inner').width();
					var pressHeight = $(this).find('.press-inner').height();
					var pressImgWidth = $(this).find('.press-img').width();
					var pressImgHeight = $(this).find('.press-img').height();
					var pressImgRt = pressImgHeight/pressImgWidth;
					//console.log(pressWidth+'/'+pressHeight+'/'+pressImgWidth+'/'+pressImgHeight+'/'+pressImgRt)
					$(this).find('.press-imgCont').css({height: .4473*pressWidth, 'overflow':'hidden'});
					$(this).find('.press-imgLink').css({width:pressWidth, height:.4473*pressWidth});
					if(pressImgRt > .4473){
						$(this).find('.press-img').css({width:pressWidth, height:pressWidth*pressImgRt, 'margin-top':-.5*pressWidth*(pressImgRt-.4473)});
					} else {
						$(this).find('.press-img').css({width:.4473*pressWidth/pressImgRt, height:.4473*pressWidth, 'margin-left':-.5*pressWidth*(.4473/pressImgRt -1)});
					}
				})
			}
		},

			
		reviewItemAlign:function(){
			$('body').on('click', '.manual-tabs li a', function(){
				setTimeout(reviewAlign, 200);
			})
			if($('.review-list').length){
				reviewAlign();
			};
		}

	}

	

})();

function tvSlider(){
	$('.tvSlider').flexslider({
		animation: 'slide',
		controlNav: false
	})
}

function shelfList(){
	$('.shelf-item').each(function(){
		var shelfWidth = $(this).find('.shelf-inner').width();
		var shelfHeight = $(this).find('.shelf-inner').height();
		var shelfImgWidth = $(this).find('.shelf-img').width();
		var shelfImgHeight = $(this).find('.shelf-img').height();
		var shelfImgRt = shelfImgHeight/shelfImgWidth;
		$(this).find('.shelf-imgCont').css({height: shelfWidth, 'overflow':'hidden'});
		$(this).find('.shelf-imgLink').css({width:shelfWidth, height:shelfWidth});
		if(shelfImgRt > 1){
			$(this).find('.shelf-img').css({width:shelfWidth, height:shelfWidth*shelfImgRt, 'margin-top':-.5*shelfWidth*(shelfImgRt-1)});
		} else {
			$(this).find('.shelf-img').css({width:shelfWidth/shelfImgRt, height:shelfWidth, 'margin-left':-.5*shelfWidth*(1/shelfImgRt -1)});
		}
	})
}

function reviewAlign(){
	$('.review-item').each(function(){
		var reviewWidth = $(this).find('.review-inner').width();
		var reviewHeight = $(this).find('.review-inner').height();
		var reviewImgWidth = $(this).find('.review-img').width();
		var reviewImgHeight = $(this).find('.review-img').height();
		var reviewImgRt = reviewImgHeight/reviewImgWidth;
		$(this).find('.review-imgCont').css({height: .6137*reviewWidth, 'overflow':'hidden'});
		$(this).find('.review-imgLink').css({width:reviewWidth, height:.6137*reviewWidth});
		if(reviewImgRt > .6137){
			$(this).find('.review-img').css({width:reviewWidth, height:reviewWidth*reviewImgRt, 'margin-top':-.5*reviewWidth*(reviewImgRt-.6137)});
		} else {
			$(this).find('.review-img').css({width:.6137*reviewWidth/reviewImgRt, height:.6137*reviewWidth, 'margin-left':-.5*reviewWidth*(.6137/reviewImgRt -1)});
		}
	})
}
$(function(){
	Sub.init();	
});