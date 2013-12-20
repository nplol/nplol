$ ->

  # Adding a new Asset field to the form.
  $('.add-asset').on 'ajax:success', (event, html) ->
    addAssetForm(html)

  $('.add-asset').on 'ajax:error', (event, xhr) ->
    failedToAddAssetForm

  addAssetForm = (html) ->
    dim(true)
    $('.dim').append(html)

  $('#close-assets-form').on 'click', (event) ->
    event.preventDefault()
    dim(false)

  failedToAddAssetForm = ->
    console.log 'Failed to load asset template :-('

  dim = (lightSwitch) ->
    prependDimmer() if !$('.dim').length > 0
    if lightSwitch then $('.dim').fadeIn('fast') else $('.dim').fadeOut('fast')

  prependDimmer = ->
    $('#main').prepend('<div class="dim"></div>')
