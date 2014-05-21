$ ->

  $container = $('#posts')
  layoutInProgress = false

  $container.packery {
    itemSelector: '.post',
    gutter: 20,
    isHorizontal: true
  }
  # }
  #
  # $('.post').hover(
  #   (event) ->
  #     return false if layoutInProgress
  #     layoutInProgress = true
  #     callback = ->
  #       $container.packery()
  #       layoutInProgress = false
  #     setTimeout(callback, 200)
  #   ,
  #   (event) ->
  #     # do nothing
  # )

  $('.post').on 'click', (event) ->
    event.preventDefault();
    post_id = $(@).data('post-id')
    $('#app').addClass('transition')

    $.ajax("/posts/#{post_id}").
      done( (html) ->
        changeView(html)
        url = "/posts/#{post_id}"
        history.pushState({ url: url }, null, url)
      ).
      fail( ->
        console.log('Loading post failed.'))
