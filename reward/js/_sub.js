  $(function() {
    $(window).scroll(function(){
      if($(this).scrollTop()>100){
        $(".header-fixed .header").addClass("header-fixed-shrink");
      }else{
        $(".header-fixed .header").removeClass("header-fixed-shrink");
      }
    });

    /** side nav **/
    $("li.list-toggle").bind("click", function() {
        $(this).toggleClass("active");
    });

    if($(".navbar-toggle").css("display") == "none"){
      $('.dropdown-toggle').addClass('disabled');
      $(".sidenav-toggle").attr("data-toggle", "collapse disabled");
    }else{
      $('.dropdown-toggle').removeClass('disabled');
      $(".sidenav-toggle").attr("data-toggle", "collapse");
    }
  });
