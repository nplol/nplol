class PostGrid

  constructor: ->
    @load()

  load: =>
    $container = $('#posts')
    $container.packery {
      itemSelector: '.post',
      gutter: 20,
      isHorizontal: true
    }
    @initBindings()
    # $('html').width($('#posts').width())

  initBindings: ->
    $('.post').on 'click', (event) ->
      event.preventDefault();
      post_id = $(@).data('post-id')
      app.fetchPost("/posts/#{post_id}")

@PostGrid = PostGrid

  # load a new form based on the input in the
  # dropdown menu - current choices: normal, meme, (quote)
  # $('.post-type').on 'change', (event) ->
  #
  #   $.ajax({
  #     url: $(@).data('formPath'),
  #     type: 'post',
  #     data:  { 'post_type': $(@).val() } })
  #     .done( (html) ->
  #       renderForm(html)
  #     )
  #     .fail( -> failedToRenderForm()
  #     )
  #
  #   renderForm = (html) ->
  #     $('#post-form').html(html)
  #
  #   failedToRenderForm = ->
  #     console.log('Failed to load post form.')
  #
  # $('.add-asset').on 'ajax:success', (event, html) ->
  #   addAssetForm(html)
  #   addListenersToAssetForm()
  #
  # addAssetForm = (html) ->
  #   dim(true)
  #   $('.dim').append(html)


  # Loading next / previous post
  # $('.arrow').on 'ajax:beforeSend', (event, xhr, settings) ->
  #   $('#main').addClass('transition')
  #
  # $('.arrow').on 'ajax:success', (event, html) ->
  #   changeView(html)
  #   url = "/posts/#{$(@).data('id')}"
  #   history.pushState({ url: url }, null, url)
  #
  # $('#main').on ' webkitTransitionEnd', (event) ->
  #   return false if $(@).hasClass('transition') || event.target != @
  #   $('.arrow').fadeIn('fast')
  #
  # $('.arrow').fadeIn('fast') unless $('#main').hasClass('transition')
