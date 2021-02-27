$(document).ready(function() {

//MOBILE ONE AND MOBILE THREE
var menu = "close";
$(".mobile-one .menu-toggle, .mobile-three .menu-toggle").click(function() {
    
    if (menu === "close") {
      	$(this).parent().next(".mobile-nav").css("transform", "translate(0, 0)");
     	 menu = "open";
    } else {
      	$(this).parent().next(".mobile-nav").css("transform", "translate(-100%, 0)");
      	menu = "close";
    }
});

//MOBILE TWO
$(".mobile-two .menu-toggle").click(function() {
	$(this).parent().next(".mobile-nav").toggle(0 , "display");
});

//MOBILE FOUR
var menu = "close";
$(".mobile-four .menu-toggle").click(function() {
    
    if (menu === "close") {
      	$(this).parent().next(".mobile-nav").css("transform", "translate(0, 0)");
     	 menu = "open";
    } else {
      	$(this).parent().next(".mobile-nav").css("transform", "translate(0, -999%)");
      	menu = "close";
    }
});




});