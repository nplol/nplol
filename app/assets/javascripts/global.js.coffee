$ ->

  # *window* is the global namespace

  # switches between the two current views: article and listing.
  window.initiateTransition = (layoutName) ->
    $('#transition-wrapper').addClass('transition')
    callback = -> changeView(layoutName)
    setTimeout( callback, 1500)

  changeView = (layoutName) ->
    $('#transition-wrapper').removeClass('transition')
    if layoutName == 'article'
      $('body').addClass('article-view').removeClass('listing-view')
      $('#listing').addClass('hidden')
      $('#article').removeClass('hidden')
    else if layoutName == 'listing'
      $('body').addClass('listing-view').removeClass('article-view')
      $('#article').addClass('hidden')
      $('#listing').removeClass('hidden')
      if $('.post').length > 0
        $('#listing').packery()
      else
        fetchPosts() unless $('.post').length > 0

  # dim the background
  window.dim = (lightSwitch) ->
    prependDimmer() unless $('.dim').length > 0
    $('.dim').html('') unless lightSwitch
    if lightSwitch then $('.dim').fadeIn('fast') else $('.dim').fadeOut('fast')

  window.clearForm = ($form) ->
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
        $('#listing').html(html))

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

    initiateTransition('listing') unless state?