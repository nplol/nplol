class CommentForm

  constructor: ->
    @$button = $('#add_comment')
    @$el = $('#comment_form_container')
    @initBindings()

  initBindings: ->
    # make sure to reload our comment form if a user logs in
    $(window).on 'auth', (event) ->
      location.reload(false)

    @$button.on 'click', (event) =>
      unless @$button.data().ready
        event.preventDefault()
        @_showForm()

    @$el.on 'submit', (event) =>
      @$button.addClass('disabled').disabled = true

    @$el.on 'ajax:success', (event, html) =>
      $('#comments').prepend(html)
      @_incrementCounter()

    @$el.on 'ajax:error', (event, xhr, status, error) =>
      @$el.html(xhr.responseText)

    @$el.on 'ajax:complete', =>
      @$button.removeClass('disabled').disabled = false
      @_clearForm()

  # private methods

  _showForm: ->
    @$el.find('.hidden').removeClass('hidden')
    @_buttonReady() unless $('.message').length > 0

  _clearForm: ->
    @$el.find('input[type="text"]').removeClass('input-error').val('')

  _buttonReady: ->
    @$button.val('Post comment')
    @$button.data('ready', true)

  _incrementCounter: ->
    $('.count').html(parseInt($('.count').text()) + 1)

@CommentForm = CommentForm
