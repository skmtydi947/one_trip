$(document).ready(function () {
  $('.main-slider').slick({
    slidesToShow: 1,
    asNavFor: '.thumbnail-slider',
    arrows: false,
  });

  $('.thumbnail-slider').slick({
    slidesToShow: 9,
    asNavFor: '.main-slider',
    focusOnSelect: true,
  });

});