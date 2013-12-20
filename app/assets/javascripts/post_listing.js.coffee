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

  $('.post').on 'click', (event) ->
    post_id = $(@).data('post-id')
    $.ajax("/posts/#{post_id}").
      done( (html) ->
        updateMainCanvas(html)
        history.pushState({  }, "", "")
        history.pushState({  }, "", "/posts/#{post_id}")
        window.history.go(2)
      ).
      fail( ->
        console.log('Loading post failed.'))




