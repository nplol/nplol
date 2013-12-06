$ ->

  # Adding a new Asset field to the form.
  $('.add-asset').on 'click', (e) ->
    e.preventDefault()
    $.ajax($(@).attr('data-url'))
    .done( (html) ->
        addAssetForm(html)
      )
    .fail( ->
        failedToAddAssetForm()
      )

  addAssetForm = (html) ->
    $('.new-assets').append(html)

  $('#close-assets-form').on 'click', (event) ->
    event.preventDefault()
    $('#assets-form-background').fadeOut('fast')

  failedToAddAssetForm = ->
    console.log 'Failed to load asset template :-('