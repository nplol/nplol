/*global $:false*/

(function() {
  "use strict";

  $(document).ready(function() {
    $(document).on('ajax:success',
      '#like_post', function (event) {
        event.preventDefault();
        $(this).find('i').addClass('red');
      });
  });
}());
