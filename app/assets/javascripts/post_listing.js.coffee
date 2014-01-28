$ ->

  $container = $('#listing')

  $container.packery {
    itemSelector: '.post',
    gutter: 20,
    isHorizontal: true
  }

  $('.post').on 'click', (event) ->

    post_id = $(@).data('post-id')

    $.ajax("/posts/#{post_id}").
      done( (html) ->
        articleView(html)
        history.pushState({ value: 'value' }, null, "/posts/#{post_id}")
        changeView('article')
      ).
      fail( ->
        console.log('Loading post failed.'))

  articleView = (html) ->
    $('#article').html(html)


