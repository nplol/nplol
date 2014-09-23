class Header

  constructor: ->
    @auth = new Auth()
    @initBindings()

  initBindings: ->
    $(document).on 'click', 'header i, header .logo-icon', (event) ->
      $(@).tipsy('hide')

    $(document).on 'click', '.google', (event) =>
      event.preventDefault()

      params = 'location=0,status=0,width=800,height=600'
      googleWindow = window.open(@auth.googleUrl, 'googleWindow', params)
      googleWindow.focus()

    $(document).on 'click', '.github', (event) =>
      event.preventDefault()

      params = 'location=0,status=0,width=800,height=600'
      githubWindow = window.open(@auth.githubUrl, 'githubWindow', params)
      githubWindow.focus()

    $(document).on 'click', '.settings', (event) ->
      $('#user-menu').toggleClass('active')

    # $('.settings').on 'click', =>
    #   @_toggleMenu()
    #
    # $('.authorize').on 'click', =>
    #   @_toggle()
    #   @_toggleMenu()
    #
    # $('.authorize').on 'ajax:error', (xhr, status, error) =>
    #   @_toggleMenu()
    #   @_toggle()
    #
    # $('.authorize').on 'ajax:success', (event, html, xhr) =>
    #   $('#user-menu').remove()
    #   setTimeout( => @_reload(html),
    #   800)
  #
  # initEvents: ->
  #   @auth.on 'auth', =>
  #     @_toggle()
  #     @_fetchHeader()
  #
  # _toggleMenu: ->
  #   $('#user-menu').toggleClass('active')
  #
  # _toggle: ->
  #   @$el.toggleClass('transition')
  #
  # _fetchHeader: ->
  #   Q($.ajax
  #       method: 'get'
  #       url: '/header'
  #       dataType: 'html'
  #   )
  #   .then(
  #     (html) =>
  #       setTimeout(=> @_reload(html),
  #       800)
  #   )
  #   .fail(
  #     (error) ->
  #       console.log error
  #   )
  #
  # _reload: (html) ->
  #   @$el.html(html)
  #   @initBindings()
  #   @_toggle()

@Header = Header
