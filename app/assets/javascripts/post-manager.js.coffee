class PostManager extends EventEmitter

  constructor: ->
    @initBindings()

  loadGrid: ->
    @postGrid = new PostGrid()
    @initEvents()

  showPost: ->
    new Post()

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
      $('.post').on 'click', (event) =>
        event.preventDefault();
        post_id = $(event.delegateTarget).data('post-id')
        @emit('fetch_post', post_id)

  @PostGrid = PostGrid

  class Post extends EventEmitter

    constructor: ->
      @$el = $('#comment_form_container')
      @commentForm = new CommentForm()
      @initBindings()
      @initEvents()

    initBindings: ->
      # make sure to reload our comment form if a user logs in
      $(window).on 'auth', (event) ->
        location.reload(false)

    initEvents: ->
      @commentForm.on 'error', (html) =>
        @$el.find('#comment_text').addClass('input-error')

      @commentForm.on 'new_comment', (html) =>
        $('#comments').prepend(html)
        $('.count').html(parseInt($('.count').text()) + 1)

    class CommentForm extends EventEmitter

      constructor: ->
        @$el = $('#new_comment')
        @$button = $('#add_comment')
        @initBindings()

      initBindings: ->
        @$button.on 'click', (event) =>
          unless @$button.data().ready
            event.preventDefault()
            @_showForm()

        @$el.on 'submit', (event) =>
          @$button.addClass('disabled').disabled = true

        @$el.on 'ajax:success', (event, html) =>
          @emit('new_comment', html)
          @_clearForm()

        @$el.on 'ajax:error', (event, xhr, status, error) =>
          @emit('error')

        @$el.on 'ajax:complete', =>
          @$button.removeClass('disabled').disabled = false

      _showForm: ->
        @$el.find('.hidden').removeClass('hidden')
        @_buttonReady() unless $('.message').length > 0

      _clearForm: ->
        @$el.find('input[type="text"]').removeClass('input-error').val('')

      _buttonReady: ->
        @$button.val('Post comment')
        @$button.data().ready = true

    @CommentForm = CommentForm

  @Post = Post

@PostManager = PostManager
