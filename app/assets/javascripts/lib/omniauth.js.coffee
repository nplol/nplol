$ ->
  Q($.ajax(
    url:'https://plus.google.com/js/client:plusone.js?onload=initGoogleAuth'
    dataType: 'script'
    cache: true
    )
  )
  .then(
    ->
      # initGoogleAuth()
      console.log 'Google oauth loaded.'
  )
  .fail(
    (error) ->
      console.log 'failed to initialize Google oauth, are you online brah?'
  )

@initGoogleAuth = ->
  $('.google').on 'click', (event) ->
    event.preventDefault()
    Q.fcall(gapi.auth.authorize,
      immediate: true
      response_type: 'code'
      cookie_policy: 'single_host_origin'
      client_id: '636455440074-nio4408qk70ljb3fb1aeo46qru34ckkd.apps.googleusercontent.com'
      scope: 'email profile'
    )
    .then(
      (response) ->
        # auth successful, post to sessions#create
    )
    .fail(
      (error) ->
    )
