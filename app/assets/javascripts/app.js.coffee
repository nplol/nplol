class App

  constructor: (options={})->
    @header = new Header()
    @post = new Post() if options.post
    @tipsy()
    @parallax()
    @flash() if options.flash

  tipsy: ->
    $('i, .logo-icon').tipsy(fade: true, gravity: 'n')

  parallax: ->
    $('.background').parallax()
  
  flash: ->
    $('.flash').addClass('active')

@App = App
