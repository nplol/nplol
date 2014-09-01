class App extends EventEmitter

  constructor: ->
    @header = new Header()
    @postManager = new PostManager()
    @$el = $('#app')
    @flash = $('.flash')
    @initEvents()

  initEvents: ->
    @.on 'post_grid', ->
      @postManager.loadGrid()

    @.on 'show_post', (post) ->
      @postManager.showPost(post.id)

    @.on 'post_form', ->
      @postForm = new PostForm()

    @postManager.on 'fetched_post', (post) =>
      history.pushState({ url: post.url }, null, post.url) unless post.ignoreHistory?
      @_changeView(post.html)

    @.on 'error', (error) =>
      @_showError(error)

    @flash.on 'click', =>
      @flash.remove()

  _changeView: (html) ->
    @$el.addClass('transition')
    timeout = =>
      @$el.html(html).removeClass('transition')
    setTimeout(timeout, 400)

  _showError: (errorMessage) ->
    @flash.text(errorMessage) if errorMessage? #errorMessage is null for synchronous calls.
    @flash.show()

@App = App
