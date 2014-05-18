$ ->

  login = (provider_url, width, height) =>
    features = "width=#{width} height=#{height}"
    popup = window.open(provider_url, 'Login', features)

    if window.focus
      popup.focus()

    popup.onunload = ->
      updateHeader()

  $('.google').on 'click', ->
    login('/auth/google_oauth2', 500, 500)
    return false
