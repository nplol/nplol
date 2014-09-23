class Header

  constructor: ->
    @auth = new Auth()
    @initBindings()

  initBindings: ->
    $(document).on 'click', 'header i, header .logo-icon', (event) ->
      $(@).tipsy('hide')

    $(document).on 'click', '.google, .github', (event) =>
      event.preventDefault()

      params = 'location=0,status=0,width=800,height=600'
      if($(event.target).hasClass('fa-google-plus'))
        authWindow = window.open(@auth.googleUrl, 'googleWindow', params)
      else
        authWindow = window.open(@auth.githubUrl, 'githubWindow', params)
      authWindow.focus()

    $(document).on 'click', '.settings, #user-menu', (event) ->
      $('#user-menu').toggleClass('active')

@Header = Header
