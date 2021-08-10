  var OwlCarousel = function () {
    return {

        //Owl Carousel
        initOwlCarousel: function () {
        jQuery(document).ready(function() {
            jQuery(document).ready(function() {
            var owl = jQuery(".owl-slider");
                owl.owlCarousel({
                  items: [4],
                    itemsDesktop : [1000,5], //5 items between 1000px and 901px
                    itemsDesktopSmall : [900,4], //4 items betweem 900px and 601px
                    itemsTablet: [600,3], //3 items between 600 and 0;
                    itemsMobile : [479,2], //2 itemsMobile disabled - inherit from itemsTablet option
                    slideSpeed: 1000
                });

                // Custom Navigation Events
                jQuery(".next-v2").click(function(){
                    owl.trigger('owl.next');
                })
                jQuery(".prev-v2").click(function(){
                    owl.trigger('owl.prev');
                })
            });
        });
    }
    };
  }();

  $(function() {
    $(window).scroll(function(){
      if($(this).scrollTop()>100){
        $(".header-fixed .header").addClass("header-fixed-shrink");
      }else{
        $(".header-fixed .header").removeClass("header-fixed-shrink");
      }
    });

    if($(".navbar-toggle").css("display") == "none"){
      $('.dropdown-toggle').addClass('disabled');
    }else{
      $('.dropdown-toggle').removeClass('disabled');
    }

    $('#latest-works').bxSlider({
        hideControlOnEnd: true,
        minSlides: 2,
        maxSlides: 4,
        slideWidth: 275,
        slideMargin: 10,
        pager: false,
        nextSelector: '#bx-next4',
        prevSelector: '#bx-prev4',
        nextText: '>',
        prevText: '<',
    })

    $('#home-block').bxSlider({
        hideControlOnEnd: true,
        minSlides: 1,
        maxSlides: 1,

        pager: false,
        nextSelector: '#bx-next5',
        prevSelector: '#bx-prev5',
        nextText: '>',
        prevText: '<',
    })

    OwlCarousel.initOwlCarousel();

    $('#da-slider').cslider({
      autoplay  : true,
      bgincrement : 450
    });

    $.ajax({
      url: '/exec/board/board.xml.asp?bc_seq=1&list_cnt=5&cut_title=50',
      dataType: "xml",
      type: 'GET',
      success: function(xml) {
        $(xml).find('list').each(function(){
          var seq = $(this).find("b_seq").text();
          var title = $(this).find("b_title").text();
          var wdate = $(this).find("b_wdate").text();

          $("#notice").append("<div class='col-xs-9 title'><i class='fa fa-circle'></i> <a href='/notice?bc_seq=1&method=view&b_seq="+seq+"'>"+title+"</a></div><div class='col-xs-3 date'>"+wdate+"</div>");
        });
      }
    });
  });
