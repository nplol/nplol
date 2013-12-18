$ ->

  $('#new_comment').on 'ajax:success', (event, html) ->
    $('#comments').append(html)

  $('#new_comment').on 'ajax:error', (event, response) ->
    $(@).html(response.responseText)
