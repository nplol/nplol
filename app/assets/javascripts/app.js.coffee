# application entry point
class App

  constructor: ->
    @header = new Header()
    @auth = new Auth()
    @$el = $('#app')
    @initBindings()

  initBindings: ->
    $(window).on 'popstate', (event) =>
      state = event.originalEvent.state
      if state && state.url != '/'
        @fetchPost(state.url)
      else
        @fetchPost(null)

    @$el.on 'comment_form', =>
      @commentForm = new CommentForm()

    @$el.on 'asset_form', (event) =>
      @_dim(true)
      @assetForm = new AssetForm()

    @$el.on 'asset_created', =>
      @_dim(false)
      delete @assetForm

    @$el.on 'post_grid', =>
      @postGrid = new PostGrid()

  fetchPost: (url = null, callback) ->
    url ||= '/'
    Q($.ajax(url)
    )
    .then(
      (html) =>
        history.pushState({ url: url }, null, url)
        @_changeView(html)
    )
    .fail(
      (error) ->
        console.log('failed to load post.')
    )

  emit: (event) =>
    @$el.trigger(event)

  toggleHeader: ->
    @header.toggle()

  reloadHeader: (html) ->
    @header.reload(html)


  # private methods

  _changeView: (html) ->
    @$el.addClass('transition')
    timeout = =>
      @$el.html(html).removeClass('transition')
    setTimeout(timeout, 400)

  _dim: (lightSwitch) ->
    @_prependDimmer() unless $('.dim').length > 0
    $('.dim').html('') unless lightSwitch
    if lightSwitch then $('.dim').fadeIn('fast') else $('.dim').fadeOut('fast')

  _prependDimmer: ->
    $('#app').prepend $('<div>', { class: 'dim'})

@App = App


  # dim the background
  # @dim = (lightSwitch) ->
  #   prependDimmer() unless $('.dim').length > 0
  #
  # @clearForm = ($form) ->
  #   $form.find('input[type=text]').val('')
  #   $form.find('textarea').val('')

  # keyCode 27: escape
  # $(document).keydown((event) ->
    # dim(false) if event.keyCode == 27
  # )



  # prependDimmer = ->
    # $('#main').prepend('<div class="dim"></div>')
  #
