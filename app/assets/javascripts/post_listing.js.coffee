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
        history.pushState({ value: 'value' }, null, "/posts/#{post_id}")
        changeView(html)
      ).
      fail( ->
        console.log('Loading post failed.'))

