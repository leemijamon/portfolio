/**
 * Created by user on 2021-02-26.
 */

// Cache selectors
var lastId,
 topMenu = $("#mainNav"),
 topMenuHeight = topMenu.outerHeight()+1,
 // All list items
 menuItems = topMenu.find("a"),
 // Anchors corresponding to menu items
 scrollItems = menuItems.map(function(){
   var item = $($(this).attr("href"));
    if (item.length) { return item; }
 });

// Bind click handler to menu items
// so we can get a fancy scroll animation
menuItems.click(function(e){
  var href = $(this).attr("href"),
      offsetTop = href === "#" ? 0 : $(href).offset().top-topMenuHeight+1;
  $('html, body').stop().animate({ 
      scrollTop: offsetTop
  }, 850);
  e.preventDefault();
});

// Bind to scroll
$(window).scroll(function(){
   // Get container scroll position
   var fromTop = $(this).scrollTop()+topMenuHeight;
   
   // Get id of current scroll item
   var cur = scrollItems.map(function(){
     if ($(this).offset().top < fromTop)
       return this;
   });
   // Get the id of the current element
   cur = cur[cur.length-1];
   var id = cur && cur.length ? cur[0].id : "";
   
   if (lastId !== id) {
       lastId = id;
       // Set/remove active class
       menuItems
         .parent().removeClass("active")
         .end().filter("[href=#"+id+"]").parent().addClass("active");
   }                   
});

$('.toggle_btn').click(function(){
	$('.mo_nav_list').slideToggle();
})


/*############## Scroll Effect ##############*/
$(document).ready(function() {
	hideObjects();
	checkObjectsVisibility();
});

$(window).scroll( function() {
	hideObjects();
	checkObjectsVisibility();
});

function hideObjects() {
	$('.fadeInUp_scroll').css({
		'opacity': 0,
		'transform': 'translateY(100px)'
	});
	$('.fadeInDown_scroll').css({
		'opacity': 0,
		'transform': 'translateY(-100px)'
	});
	$('.fadeInLeft_scroll').css({
		'opacity': 0,
		'transform': 'translateX(-100px)'
	});
	$('.fadeInRight_scroll').css({
		'opacity': 0,
		'transform': 'translateX(100px)'
	});
	$('.fadeInScale_scroll').css({
		'opacity': 0,
		'transform': 'scale(0,0)'
	});

}

function checkObjectsVisibility() {
	$('.fadeIn_scroll').each( function(i) {
		var objectTop = $(this).offset().top;
		var windowBottom = $(window).scrollTop() + $(window).outerHeight();

		if( windowBottom > objectTop - 100){
			$(this).addClass('visible');
		} else {
			$(this).removeClass('visible');
		}
	});
}