class App extends EventEmitter

  constructor: ->
    @header = new Header()
    @postManager = new PostManager()
    @$el = $('#app')
    @initEvents()

  initEvents: ->
    @.on 'post_grid', ->
      @postManager.loadGrid()

    @.on 'post_form', ->
      @postForm = new PostForm()

    @postManager.on 'fetched_post', (post) =>
      history.pushState({ url: post.url }, null, post.url)
      @_changeView(post.html)

    @.on 'dim', (lightSwitch) =>
      @_dim(lightSwitch)

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
