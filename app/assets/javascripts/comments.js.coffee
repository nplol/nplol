class CommentForm

  constructor: ->
    @$button = $('#add_comment')
    @$form = $('#new_comment')
    @initBindings()

  initBindings: ->
    # make sure to reload our comment form if a user logs in
    $(window).on 'auth', (event) ->
      location.reload(false)

    @$button.on 'click', (event) =>
      unless @$button.data().ready
        event.preventDefault()
        @_showForm()

    @$form.on 'submit', (event) =>
      @$button.addClass('disabled').disabled = true

    @$form.on 'ajax:success', (event, html) =>
      $('#comments').prepend(html)
      @_incrementCounter()

    @$form.on 'ajax:error', (event, xhr, status, error) =>
      $('#comment_form_container').html(xhr.responseText)

    @$form.on 'ajax:complete', =>
      @$button.removeClass('disabled').disabled = false
      @_clearForm()

  # private methods

  _showForm: ->
    @$form.find('.hidden').removeClass('hidden')
    @_buttonReady() unless $('.message').length > 0

  _clearForm: ->
    @$form.find('input[type="text"]').removeClass('input-error').val('')

  _buttonReady: ->
    @$button.val('Post comment')
    @$button.data('ready', true)

  _incrementCounter: ->
    $('.count').html(parseInt($('.count').text()) + 1)

@CommentForm = CommentForm
