$ ->

  # class containing global methods and variables.
  window.updateMainCanvas = (html) ->
    $('#main').html(html)

  getListingLayout = ->
    return false if $('.posts').length > 0
    $.ajax('')
      .done((html) ->
        updateMainCanvas(html)
      )
      .fail(-> console.log('Failed to load main layout.'))

  $(window).on 'popstate', (event) ->
    if(event.originalEvent.state != null)
      getListingLayout()