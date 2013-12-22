$ ->

  $('#new_asset').on 'ajax:success', (event, html) ->
    $('.assets').append(html)

  $('#new_asset').on 'ajax:error', (event, html) ->
    $('.dim').html(html.responseText)