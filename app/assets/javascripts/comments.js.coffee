$ ->

  $('#add_comment').on 'click', (event) ->
    unless $(@).data().ready
      _showForm()

  $('#new_comment').on 'ajax:success', (event, html) ->
    $('#comments').append(html)
    clearForm($(@))

  $('#new_comment').on 'ajax:error', (event, xhr, status, error) ->
    $(@).html(xhr.responseText)

  _showForm: ->
    $()
