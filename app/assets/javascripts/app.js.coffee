class App extends EventEmitter

  constructor: ->
    @header = new Header()
    @postManager = new PostManager()
    @$el = $('#app')
    @initEvents()

  initEvents: ->
    @.on 'post_grid', ->
      @postManager.loadGrid()

    @.on 'show_post', ->
      @postManager.showPost()

    @.on 'post_form', ->
      @postForm = new PostForm()

    @postManager.on 'fetched_post', (post) =>
      history.pushState({ url: post.url }, null, post.url)
      @_changeView(post.html)

  _changeView: (html) ->
    @$el.addClass('transition')
    timeout = =>
      @$el.html(html).removeClass('transition')
    setTimeout(timeout, 400)

@App = App
