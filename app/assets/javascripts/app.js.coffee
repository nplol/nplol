class App

  constructor: (options={})->
    @header = new Header()
    @commentHandler = new CommentHandler() if options.comments
    @tipsy()
    @parallax()

  tipsy: ->
    $('i, .logo-icon').tipsy(fade: true, gravity: 'n')

  parallax: ->
    $('.background').parallax()

@App = App
