$ ->

  $container = $('#posts')

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
        $container.packery()
      ).
      fail( ->
        console.log('Loading post failed.'))




