class PostManager extends EventEmitter

  constructor: ->
    @initBindings()

  loadGrid: ->
    @postGrid = new PostGrid()
    @initEvents()

  initBindings: ->
    $(window).on 'popstate', (event) =>
      state = event.originalEvent.state
      if state && state.url != '/'
        @fetchPost(state.url)
      else
        @fetchPost(null)

  initEvents: ->
    @postGrid.on 'fetch_post', (post_id) =>
      @fetchPost("/posts/#{post_id}")

  fetchPost: (url = null) ->
    url ||= '/'
    Q($.ajax(url)
    )
    .then(
      (html) =>
        @emit('fetched_post', {html: html, url: url} )
    )
    .fail(
      (error) ->
        console.log('failed to load post.')
    )

  class PostGrid extends EventEmitter

    constructor: ->
      $grid = $('#posts')
      $grid.packery {
        itemSelector: '.post',
        gutter: 20,
        isHorizontal: true
      }
      @initBindings()

    initBindings: ->
      # TODO: fix, eugh
      that = @
      $('.post').on 'click', (event) ->
        event.preventDefault();
        post_id = $(@).data('post-id')
        that.emit('fetch_post', post_id)

  @PostGrid = PostGrid

@PostManager = PostManager
