$ =>
  $('.tipsy').remove()
  $('#user-menu').detach().appendTo('body')

  $('header i')
  .on 'click', ->
    $(@).tipsy 'hide'
  .tipsy {fade: true, gravity: 'n', block: -> !($('#user-menu').hasClass('active') && @$element.hasClass('fa-cog')) }

  $('.settings')
  .on 'click', =>
    showMenu()

  showMenu = ->
    $('#user-menu').toggleClass('active')

  $('.logout').on 'ajax:success', (event, html, xhr) =>
    updateHeader(html)
