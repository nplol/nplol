$ ->

  # class containing global methods and variables.

  window.updateMainCanvas = (html) ->
    $('#main').html(html)

  getListingLayout = ->
    $.ajax('')
      .done((html) ->
        updateMainCanvas(html)
      )
      .fail(-> console.log('Failed to load main layout.'))

  # add CSRF token to AJAX requests.
  $(document).on 'ajax:beforeSend', (event,xhr) ->
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))

  $(window).on 'popstate', (event) ->
    if(event.originalEvent.state != null)
      getListingLayout()