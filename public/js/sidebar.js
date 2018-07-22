const $ = jQuery;

$(document).ready(() => {
  $(() => {
    $('.fa-trash').hide();

    $(".topics").hover(() => {
      $('.fa-trash').show();
      $('.fa-check').hide();
    }, () => {
      $('.fa-trash').hide();
      $('.fa-check').show();
    });
  });
});
