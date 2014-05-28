$ ->
  # make sure to reload our comment form if a user logs in
  $(window).on 'auth', (event) ->
    location.reload(false)

  $form = $('#new_comment')
  $button = $('#add_comment')

  $button.on 'click', (event) ->
    unless $button.data().ready
      event.preventDefault()
      _showForm()

  $form.on 'submit', (event) ->
    $button.addClass('disabled').disabled = true

  $form.on 'ajax:success', (event, html) ->
    $('#comments').prepend(html)

  $form.on 'ajax:error', (event, xhr, status, error) ->
    $form.html(xhr.responseText)

  $form.on 'ajax:complete', ->
    $button.removeClass('disabled').disabled = false
    _clearForm()

  _showForm = ->
    $form.find('.hidden').removeClass('hidden')
    _buttonReady() unless $('.message').length > 0

  _clearForm = ->
    $form.find('input[type="text"]').removeClass('input-error').val('')

  _buttonReady = ->
    $button.val('Post comment')
    $button.data('ready', true)
