const $ = jQuery;

$(document).ready(() => {
  $(() => {
    $('.confirm-password').hide();
    $('.register_button').hide();
    $('.toggle-login').hide();

    $('.to_register').click(() => {
      $('.login_button').hide();
      $('.toggle-register').hide();
      $('.email').css('top', '3vh');
      $('.password').css('top', '5vh');
      $('.confirm-password').css('top', '6vh');
      $('.remember').css('top', '7vh');
      $('.register_button').css('top', '9vh');
      $('.toggle-login').css('top', '11vh');
      $('.confirm-password').show();
      $('.register_button').show();
      $('.toggle-login').show();
      return false;
    });

    $('.to_login').click(() => {
      $('.confirm-password').hide();
      $('.register_button').hide();
      $('.toggle-login').hide();
      $('.email').css('top', '8vh');
      $('.password').css('top', '12vh');
      $('.remember').css('top', '13vh');
      $('.login_button').show();
      $('.toggle-register').show();
      return false;
    });

    if(!RegExp.escape) {
      RegExp.escape = function(s) {
        return String(s).replace(/[\\^$*+?.()|[\]{}]/g, '\\$&');
      };
    }
  });
});
