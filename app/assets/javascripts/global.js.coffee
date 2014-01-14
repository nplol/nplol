$ ->

  # _window_ is the global namespace

  window.updateMainCanvas = (html) ->
    $('#main').html(html)

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

  # To support ajax navigation a state is added TWICE when a post is loaded into the main view,
  # so that when backspace is pressed you get sent back to the main page.
  $(window).on 'popstate', (event) ->
    if(event.originalEvent.state != null)
      getListingLayout()

  getListingLayout = ->
    return false if $('.posts').length > 0
    $.ajax('')
      .done((html) ->
        updateMainCanvas(html)
      )
      .fail(-> console.log('Failed to load main layout.'))