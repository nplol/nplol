/*global $:false, _:false*/

(function() { 
  "use strict";

  $(document).ready(function() {

    var posts = $('.post');
    _.forEach(posts, function(post) {
      var rowStart = setRow(post);
      createRow(rowStart);
    });

    function setRow(post) {
      var index = _.indexOf(posts, post);
      if(wrapped(post)) {
        return;
      }
      return findRowStart(post, index);
    }

    function createRow(start) {
      var postRow = [];
      postRow.push(posts[start], posts[start+1]);
      if( !$(posts[start]).hasClass('popular') &&
          !$(posts[start+1]).hasClass('popular')) {
        postRow.push(posts[start+2]);
      }
      $(postRow).wrapAll('<section class="row">');
    }

    function findRowStart(post, index) {
      if(index === 0) { return index; }
      var prev = posts[index-1];
      if(wrapped(prev)) {
        return index;
      } 
      return findRowStart(prev, --index);
    }

    function wrapped(el) {
      return $(el).parent('.row').length > 0;
    }
  });
}());
