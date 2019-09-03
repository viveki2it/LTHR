// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require bootstrap-sprockets
//= require popover
//= require toastr_rails
//= require owl.carousel.min.js

// $(document).ready(function(){
//   $('.owl-carousel').owlCarousel({
//       loop:true,
//       margin:10,
//       nav:false,
//       responsive:{
//           0:{
//               items:1
//           },
//           600:{
//               items:2
//           },
//           1000:{
//               items:3
//           }
//       }
//   })
// });

$(document).ready(function () {
    $('.play').click(function (e) {
        e.preventDefault();
        var video = '<iframe width="100%" height="100%" src="https://www.youtube.com/embed/HcL-2Of-0x0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" frameborder="0" allowfullscreen></iframe>';
        $('.video-wrapper').html(video);
        $('.pop-up').show();
        $('.pop-up').addClass("show-pop");
    });
    $('.close').click(function () {
        $('.video-wrapper').empty();
        $('.pop-up').removeClass("show-pop");
        $('.pop-up').hide();
    });
});