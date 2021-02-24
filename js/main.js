/**
 * Created by user on 2019-05-29.
 */

/* One Page Scroll */
$(document).ready(function () {

    var navLink = $('.nav ul li a');

    navLink.on('click', function(event) {
        event.preventDefault();
        var target = $(this).attr('href');
        var top = $(target).offset().top;
        $('html, body').animate({scrollTop: top-80}, 500);
    });

    // Nav 활성화
    var Btn = $("ul > li");
    Btn.find("a").click(function(){
        Btn.removeClass("active");
        $(this).parent().addClass("active");
    })

});

/* Gallery Hover Effect */
(function() {

    function init() {
        var speed = 330,
            easing = mina.backout;

        [].slice.call ( document.querySelectorAll( '.galleryWrap > a' ) ).forEach( function( el ) {
            var s = Snap( el.querySelector( 'svg' ) ), path = s.select( 'path' ),
                pathConfig = {
                    from : path.attr( 'd' ),
                    to : el.getAttribute( 'date-path-hover' )
                };

            el.addEventListener( 'mouseenter', function () {
                path.animate( { 'path' : pathConfig.to }, speed, easing );
            } );

            el.addEventListener( 'mouseleave', function () {
                path.animate( { 'path' : pathConfig.from }, speed, easing );
            } );
        } );
    }

    init();

})();