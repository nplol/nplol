class Auth extends EventEmitter
  constructor: ->
    @googleAuth = new GoogleAuth()
    @githubAuth = new GithubAuth()
    @initBindings()

  initBindings: ->
    $(window).on 'auth', =>
      @emit('auth')

  class GoogleAuth

    constructor: ->
      @url = '/auth/google_oauth2'
      @initBindings()

    initBindings: ->
      $('.google').on 'click', (event) =>
        event.preventDefault()

        params = 'location=0,status=0,width=800,height=600'
        googleWindow = window.open(@url, 'googleWindow', params)
        googleWindow.focus()

  @GoogleAuth = GoogleAuth

  class GithubAuth
    constructor: ->
      @url = '/auth/github'
      @initBindings()

    initBindings: ->
      $('.github').on 'click', (event) =>
        event.preventDefault()

        params = 'location=0,status=0,width=800,height=600'
        github_window = window.open(@url, 'githubWindow', params)
        github_window.focus()

  @GithubAuth = GithubAuth

@Auth = Auth


# class TwitterAuth
#
#   constructor: ->
#     @url = '/auth/twitter'
#
#     $('.twitter').on 'click', (event) =>
#       event.preventDefault()
#
      # params = 'location=0,status=0,width=800,height=600'
      # @twitter_window = window.open(@url, 'twitterWindow', params)
      # @twitter_window.focus()
    #
    # $(window).on 'auth', (event) =>
    #   app.toggleHeader()
    #   Q($.ajax
    #       method: 'get'
    #       url: '/header'
    #       dataType: 'html'
    #   )
    #   .then(
    #     (html) ->
    #       setTimeout( -> app.reloadHeader(html),
    #       800)
    #   )
    #   .fail(
    #     (error) ->
    #       console.log error
    #   )
#
# @TwitterAuth = TwitterAuth
