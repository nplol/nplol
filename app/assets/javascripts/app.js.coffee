# application entry point
class App

  constructor: ->
    @postGrid = new PostGrid()
    @header = new Header()
    @auth = new Auth()
    @initBindings()

  initBindings: ->
    $(window).on 'popstate', (event) =>

      state = event.originalEvent.state
      if state && state.url != '/'
        @fetchPost(state.url)
      else
        @fetchPost(null, @postGrid.load)

  fetchPost: (url = null, callback) ->
    url ||= '/'
    Q($.ajax(url)
    )
    .then(
      (html) =>
        history.pushState({ url: url }, null, url)
        @_changeView(html, callback)
    )
    .fail(
      (error) ->
        console.log('failed to load post.')
    )

  toggleHeader: ->
    @header.toggle()

  reloadHeader: (html) ->
    @header.reload(html)


  # private methods

  _changeView: (html, callback) ->
    $('#app').addClass('transition')
    timeout = ->
      $('#app').html(html).removeClass('transition')
      callback() if callback?
    setTimeout(timeout, 400)

@App = App


  # dim the background
  # @dim = (lightSwitch) ->
  #   prependDimmer() unless $('.dim').length > 0
  #   $('.dim').html('') unless lightSwitch
  #   if lightSwitch then $('.dim').fadeIn('fast') else $('.dim').fadeOut('fast')
  #
  # @clearForm = ($form) ->
  #   $form.find('input[type=text]').val('')
  #   $form.find('textarea').val('')

  # keyCode 27: escape
  # $(document).keydown((event) ->
    # dim(false) if event.keyCode == 27
  # )



  # prependDimmer = ->
    # $('#main').prepend('<div class="dim"></div>')
  #
