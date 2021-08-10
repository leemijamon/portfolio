  function AjaxloadURL(url, container) {
    $.ajax({
      type : "GET",
      url : url,
      dataType : 'html',
      cache : true, // (warning: this will cause a timestamp and will call the request twice)
      beforeSend : function() {
        container.html('<h1><i class="fa fa-cog fa-spin"></i> Loading...</h1>');

        if (container[0] == $("#content")[0]) {
          //drawBreadCrumb();
          document.title = $(".breadcrumb li:last-child").text();
          $("html, body").animate({
            scrollTop : 0
          }, "fast");
        } else {
          container.animate({
            scrollTop : 0
          }, "fast");
        }
      },
      success : function(data) {
        //alert(data);
        container.css({
          opacity : '0.0'
        }).html(data).delay(50).animate({
          opacity : '1.0'
        }, 300);
      },
      error : function(xhr, ajaxOptions, thrownError) {
        container.html('<h4 style="margin-top:10px; display:block; text-align:left"><i class="fa fa-warning txt-color-orangeDark"></i> Error 404! Page not found.</h4>');
      },
      async : false
    });
  }
