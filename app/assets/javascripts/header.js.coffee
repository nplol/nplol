class Header

  constructor: ->
    @$el = $('header')
    @auth = new Auth()
    @initBindings()
    @initEvents()

  initBindings: ->
    $('header i, header .logo-icon')
    .on 'click', ->
      $(@).tipsy 'hide'
    .tipsy {fade: true, gravity: 'n', block: -> !($('#user-menu').hasClass('active') && @$element.hasClass('fa-cog')) }

    $('.settings').on 'click', =>
      @_toggleMenu()

    $('.authorize').on 'click', =>
      @_toggle()
      @_toggleMenu()

    $('.authorize').on 'ajax:error', (xhr, status, error) =>
      @_toggleMenu()
      @_toggle()

    $('.authorize').on 'ajax:success', (event, html, xhr) =>
      $('#user-menu').remove()
      setTimeout( => @_reload(html),
      800)

  initEvents: ->
    @auth.on 'auth', =>
      @_toggle()
      @_fetchHeader()

  _toggleMenu: ->
    $('#user-menu').toggleClass('active')

  _toggle: ->
    @$el.toggleClass('transition')

  _fetchHeader: ->
    Q($.ajax
        method: 'get'
        url: '/header'
        dataType: 'html'
    )
    .then(
      (html) =>
        setTimeout(=> @_reload(html),
        800)
    )
    .fail(
      (error) ->
        console.log error
    )

  _reload: (html) ->
    @$el.html(html)
    @initBindings()
    @_toggle()

@Header = Header
