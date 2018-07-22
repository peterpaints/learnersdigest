const $ = jQuery;

$(document).ready(() => {
  $(() => {
    $('.register_form').hide();

    $('.to_register').click(() => {
      $('.login_form').hide();
      $('.register_form').show();
      $('.email').css('top', '3vh');
      $('.password').css('top', '4.5vh');
      $('.confirm-password').css('top', '6vh');
      $('.remember').css('top', '7vh');
      $('.register_button').css('top', '9vh');
      $('.toggle-login').css('top', '11vh');
      return false;
    });

    $('.to_login').click(() => {
      $('.login_form').show();
      $('.register_form').hide();
      $('.email').css('top', '8vh');
      $('.password').css('top', '12vh');
      $('.remember').css('top', '13vh');
      return false;
    });

    if(!RegExp.escape) {
      RegExp.escape = function(s) {
        return String(s).replace(/[\\^$*+?.()|[\]{}]/g, '\\$&');
      };
    }
  });
});
