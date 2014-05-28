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

  $form.on 'ajax:success', (event, html) ->
    $('#comments').append(html)
    _clearForm()

  $form.on 'ajax:error', (event, xhr, status, error) ->
    $(@).html(xhr.responseText)

  _showForm = ->
    $form.find('.hidden').removeClass('hidden')
    _buttonReady()

  _clearForm = ->
    $form.find('input[type="text"]').removeClass('input-error').val('')

  _buttonReady = ->
    $button.val('Post comment')
    $button.data('ready', true)
