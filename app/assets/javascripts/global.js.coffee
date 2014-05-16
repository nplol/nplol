$ ->

  # *window* is the global namespace

  # switches between the two current views: article and listing.
  @changeView = (html) ->
    $('#spinner').fadeIn('fast')
    $('.arrow').fadeOut('fast')
    callback = ->
      $('#main').html(html).removeClass('transition')
      $('#spinner').fadeOut('fast')
    setTimeout(callback, 1250)

  # dim the background
  @dim = (lightSwitch) ->
    prependDimmer() unless $('.dim').length > 0
    $('.dim').html('') unless lightSwitch
    if lightSwitch then $('.dim').fadeIn('fast') else $('.dim').fadeOut('fast')

  @clearForm = ($form) ->
    $form.find('input[type=text]').val('')
    $form.find('textarea').val('')

  # keyCode 27: escape
  $(document).keydown((event) ->
    dim(false) if event.keyCode == 27
  )

  prependDimmer = ->
    $('#main').prepend('<div class="dim"></div>')

  fetchPosts = ->
    $.ajax('/')
      .done((html) ->
        changeView(html)
        $('#posts').packery())

  fetchPost = (url) ->
    $.ajax(url).
      done( (html) ->
        changeView(html)).
      fail( ->
        console.log('failed to load post.'))

  # hack due to popstate being fired instantly in chrome.
  # http://stackoverflow.com/questions/7860960/popstate-returns-event-state-is-undefined
  popped = ('state' in window.history)
  initialURL = location.href

  $(window).on 'popstate', (event) ->
    initialPop = !popped && location.href == initialURL
    popped = true
    return if initialPop

    # only pushState applies state to the event.
    state = event.originalEvent.state

    $('#main').addClass('transition')
    debugger
    if state
      fetchPost(state.url)
    else
      fetchPosts()
