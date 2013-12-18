$ ->

  # class containing global methods and variables.

  window.updateMainCanvas = (html) ->
    $('#main').html(html)

  # add CSRF token to AJAX requests.
  $(document).on 'ajax:beforeSend', (event,xhr) ->
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))