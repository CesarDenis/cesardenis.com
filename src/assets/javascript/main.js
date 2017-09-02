
(function($) {
  'use strict';
  
  $(".page-scroll a").on("click", function(event) {
    var link = $(this);
    $("html, body").stop().animate({
      scrollTop: $(link.attr("href")).offset().top
    }, 1500, "easeInOutExpo"), event.preventDefault()
  });

  // jQuery to collapse the navbar on scroll
  $(window).scroll(function() {
    if ($(".navbar").offset().top > 50) {
        $(".fixed-top").addClass("top-nav-collapse");
    } else {
        $(".fixed-top").removeClass("top-nav-collapse");
    }
  });
  
}(jQuery));