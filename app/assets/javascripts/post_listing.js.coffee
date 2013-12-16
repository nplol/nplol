$ ->
  resizePosts = ($posts, height) ->
    $posts.each (index, element) ->
      $(element).css('height', 0.47*height+'px')

  $container = $('#posts')

  height = $(window).height() - 100

  resizePosts($('.post'), height)

  $container.css('height', height+'px')

  $container.packery {
    itemSelector: '.post',
    gutter: 20,
    isHorizontal: true
  }



