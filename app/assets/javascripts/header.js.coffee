class Header

  constructor: ->
    @$el = $('header')
    @initBindings()

  reload: (html) ->
    @$el.html(html)
    @initBindings()
    @toggle()

  initBindings: =>
    $('header i, header .logo-icon')
    .on 'click', ->
      $(@).tipsy 'hide'
    .tipsy {fade: true, gravity: 'n', block: -> !($('#user-menu').hasClass('active') && @$element.hasClass('fa-cog')) }

    $('.settings')
    .on 'click', =>
      @toggleMenu()

    $('.authorize').on 'click', =>
      @toggle()
      @toggleMenu()

    $('.authorize').on 'ajax:error', (xhr, status, error) =>
      @toggleMenu()
      @toggle()

    $('.authorize').on 'ajax:success', (event, html, xhr) =>
      $('#user-menu').remove()
      setTimeout( => @reload(html),
      800)

  toggleMenu: ->
    $('#user-menu').toggleClass('active')

  toggle: ->
    @$el.toggleClass('transition')

@Header = Header
