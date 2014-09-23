class App

  constructor: ->
    @header = new Header()
    @initBindings()
    @tipsy()
    @parallax()

  initBindings: ->

  tipsy: ->
    $('i, .logo-icon').tipsy(fade: true, gravity: 'n')

  parallax: ->
    $('.background').parallax()

@App = App
