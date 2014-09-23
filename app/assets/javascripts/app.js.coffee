class App

  constructor: (options={})->
    @header = new Header()
    @post = new Post() if options.post
    @tipsy()
    @parallax()

  tipsy: ->
    $('i, .logo-icon').tipsy(fade: true, gravity: 'n')

  parallax: ->
    $('.background').parallax()

@App = App
