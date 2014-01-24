$ ->

  # load a new form based on the input in the
  # dropdown menu - current choices: normal, meme, (quote)
  $('.post-type').on 'change', (event) ->

    $.ajax({
      url: $(@).data('formPath'),
      type: 'post',
      data:  { 'post_type': $(@).val() } })
      .done( (html) ->
        renderForm(html)
      )
      .fail( -> failedToRenderForm()
      )

    renderForm = (html) ->
      $('#post-form').html(html)

    failedToRenderForm = ->
      console.log('Failed to load post form.')

  $('.add-asset').on 'ajax:success', (event, html) ->
    addAssetForm(html)
    addListenersToAssetForm()

  addAssetForm = (html) ->
    dim(true)
    $('.dim').append(html)
