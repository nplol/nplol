$ =>
  # load the Google oauth client library
  $.ajax
    url:'https://apis.google.com/js/client:plus.js?onload=initGoogleAuth'
    dataType: 'script'
    cache: true

  class GoogleAuth

    constructor: ->
      @clientId = '636455440074-nceplif7r2ldtnhdsg8dsi56ee1bmof3.apps.googleusercontent.com'
      @apiKey = 'AIzaSyAYuhT2qzk1Pb2fzPlT7SfFhieeNr6kge0'
      @scope = 'email profile'

      gapi.client.setApiKey(@apiKey)

      $('.google').on 'click', (event) =>
        event.preventDefault()
        gapi.auth.authorize
          client_id: @clientId
          scope: @scope
          immediate: true
          response_type: 'code'
          @googleAuthCallback

    googleAuthCallback: (authResponse) ->
      if !authResponse || authResponse.error
        return console.log 'Google auth failed'
      csrf_token = $('.omniauth-token').text()
      authResponse.state = csrf_token
      closeHeader()
      Q($.ajax
          method: 'post'
          url: '/auth/google_oauth2/callback'
          dataType: 'html'
          data: authResponse
      )
      .then(
        (html) ->
          showHeader(html)
      )
      .fail(
        (error) ->
          console.log error
      )

  class TwitterAuth

    constructor: (@url)->

      $('.twitter').on 'click', (event) =>
        event.preventDefault()

        params = 'location=0,status=0,width=800,height=600'
        @twitter_window = window.open(@url, 'twitterWindow', params)
        @twitter_window.focus()

      $(window).on 'auth', (event) =>
        closeHeader()
        Q($.ajax
            method: 'get'
            url: '/header'
            dataType: 'html'
        )
        .then(
          (html) ->
            setTimeout(-> showHeader(html),
            800)
        )
        .fail(
          (error) ->
            console.log error
        )

  @TwitterAuth = new TwitterAuth('/auth/twitter')

  @initGoogleAuth = ->
    new GoogleAuth()
