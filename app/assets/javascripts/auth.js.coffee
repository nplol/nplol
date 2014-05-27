# load the Google oauth client library

class Auth
  constructor: ->
    @googleAuth = new GoogleAuth()
    @githubAuth = new GithubAuth()

  class GoogleAuth

    constructor: ->
      @url = '/auth/google_oauth2'

      $('.google').on 'click', (event) =>
        event.preventDefault()

        params = 'location=0,status=0,width=800,height=600'
        @googleWindow = window.open(@url, 'googleWindow', params)
        @googleWindow.focus()


        $(window).on 'auth', (event) =>
          app.toggleHeader()
          Q($.ajax
              method: 'get'
              url: '/header'
              dataType: 'html'
          )
          .then(
            (html) ->
              setTimeout( -> app.reloadHeader(html),
              800)
          )
          .fail(
            (error) ->
              console.log error
          )

  @GoogleAuth = GoogleAuth

  class GithubAuth
    constructor: ->
      @url = '/auth/github'

      $('.github').on 'click', (event) =>
        event.preventDefault()

        params = 'location=0,status=0,width=800,height=600'
        @github_window = window.open(@url, 'githubWindow', params)
        @github_window.focus()


        $(window).on 'auth', (event) =>
          app.toggleHeader()
          Q($.ajax
              method: 'get'
              url: '/header'
              dataType: 'html'
          )
          .then(
            (html) ->
              setTimeout( -> app.reloadHeader(html),
              800)
          )
          .fail(
            (error) ->
              console.log error
          )

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
