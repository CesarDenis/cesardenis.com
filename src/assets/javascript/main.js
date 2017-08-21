
(function($) {
  'use strict';
  
  $(".page-scroll a").on("click", function(event) {
    var link = $(this);
    $("html, body").stop().animate({
      scrollTop: $(link.attr("href")).offset().top
    }, 1500, "easeInOutExpo"), event.preventDefault()
  });
  
}(jQuery));