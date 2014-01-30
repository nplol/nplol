$ ->

  $container = $('#posts')

  $container.packery {
    itemSelector: '.post',
    gutter: 20,
    isHorizontal: true
  }

  $('.post').on 'click', (event) ->

    post_id = $(@).data('post-id')
    $('#main').addClass('transition')

    $.ajax("/posts/#{post_id}").
      done( (html) ->
        changeView(html)
        history.pushState({ value: 'value' }, null, "/posts/#{post_id}")
      ).
      fail( ->
        console.log('Loading post failed.'))

