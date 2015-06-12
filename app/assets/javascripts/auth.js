/*global $:false*/

(function() {
  "use strict";

  var googleUrl = '/auth/google_oauth2';

  $(document).ready(function() {
    $(document).on('click', '.google', function (event) {
      event.preventDefault();
      var params = 'location=0,status=0,width=800,height=600';
      var authWindow = window.open(googleUrl, 'googleWindow', params);
      authWindow.focus();
    });

    $(document).on('click', 
      '.settings, #user-menu', function (event) {
        $('#user-menu').toggleClass('active');
    });

  });
}());
