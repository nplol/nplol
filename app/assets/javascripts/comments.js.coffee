$ ->

  $('#new_comment').on 'ajax:success', (event, html) ->
    $('#comments').append(html)
    clearForm($(@))

  $('#new_comment').on 'ajax:error', (event, xhr, status, error) ->
    $(@).html(xhr.responseText)

