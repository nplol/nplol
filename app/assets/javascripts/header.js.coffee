$ ->
  $('.tipsy').remove()
  $('#user-menu').detach().appendTo('body')

  $('header i')
  .tipsy {fade: true, gravity: 'n', block: -> !($('#user-menu').hasClass('active'))}

  $('.settings')
  .on 'click', =>
    showMenu()

  $('.new-post')
  .on 'click', ->
    debugger

  showMenu = ->
    leftPosition = $('.settings').offset().left - $('.settings').width()/2
    $('#user-menu').toggleClass('active')
