class PostManager.Post.CommentForm extends EventEmitter

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
        return false if @requestInProgress
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

@PostManager.Post.CommentForm = PostManager.Post.CommentForm
