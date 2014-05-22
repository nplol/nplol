# application entry point
class App

  constructor: ->
    @postGrid = new PostGrid()
    @header = new Header()
    @initBindings()

  initBindings: ->
    $(window).on 'popstate', (event) =>

      # only pushState applies state to the event.
      state = event.originalEvent.state

      if state && state.url != '/'
        @fetchPost(state.url)
      else
        @fetchPost(null, @postGrid.reload)
      # state ? _fetchPost(state.url) : _fetchPost(null, PostGrid.reload)


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

  # hack due to popstate being fired instantly in chrome.
  # http://stackoverflow.com/questions/7860960/popstate-returns-event-state-is-undefined
  # popped = ('state' in window.history)
  # initialURL = location.href
  #
  # $(window).on 'popstate', (event) ->
  #   # debugger
  #   # initialPop = !popped && location.href == initialURL
  #   # popped = true
  #   # return if initialPop
  #
  #   # only pushState applies state to the event.
  #   state = event.originalEvent.state
  #
  #   $('#app').addClass('transition')
  #   if state
  #     fetchPost(state.url)
  #   else
  #     fetchPosts()
