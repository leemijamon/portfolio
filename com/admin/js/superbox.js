/*
  SuperBox v1.0.0
  by Todd Motto: http://www.toddmotto.com
  Latest version: https://github.com/toddmotto/superbox

  Copyright 2013 Todd Motto
  Licensed under the MIT license
  http://www.opensource.org/licenses/mit-license.php

  SuperBox, the lightbox reimagined. Fully responsive HTML5 image galleries.
*/
;(function($) {

  $.fn.SuperBox = function(options) {

    var superbox      = $('<div class="superbox-show"></div>');
    var superboximg   = $('<img src="" class="superbox-current-img"><div id="imgInfoBox" class="superbox-imageinfo inline-block"> <h1>Image Title</h1><span><p><em>thisimage.jpg</em></p><p class="superbox-img-description">Image description</p><p><a href="javascript:void(0);" class="btn btn-primary btn-sm btn-edit">Edit image</a> <a href="javascript:void(0);" class="btn btn-danger btn-sm btn-del">Delete</a></p></span> </div>');
    var superboxclose = $('<div class="superbox-close"></div>');

    superbox.append(superboximg).append(superboxclose);

    return this.each(function() {

      $('.superbox-list').click(function() {
        var currentimg = $(this).find('.superbox-img');
        var imgData = currentimg.data('img');
        superboximg.attr('src', imgData + '?w=600');

        $(".superbox-list").removeClass("active");
        $(this).addClass("active");

        description=currentimg.attr("alt")||"No description";
        imgseq=currentimg.attr("data-seq")||"No Title";
        title=currentimg.attr("title")||"No Title";
        img=imgData;

        superboximg.find("em").text(img),
        superboximg.find(">:first-child").text(title);
        superboximg.find(".superbox-img-description").text(description);

        superboximg.find(".btn-edit").attr("href", "javascript:img_edit(" + imgseq + ");");
        superboximg.find(".btn-del").attr("href", "javascript:img_del(" + imgseq + ");");

        if($('.superbox-current-img').css('opacity') == 0) {
          $('.superbox-current-img').animate({opacity: 1});
        }

        if ($(this).next().hasClass('superbox-show')) {
          superbox.toggle();
        } else {
          superbox.insertAfter(this).css('display', 'block');
        }

        $('html, body').animate({
          scrollTop:superbox.position().top - currentimg.width()
        }, 'medium');
      });

      $('.superbox').on('click', '.superbox-close', function() {
        $('.superbox-current-img').animate({opacity: 0}, 200, function() {
          $('.superbox-show').slideUp();
          $(".superbox-list").removeClass("active");
        });
      });

    });
  };
})(jQuery);