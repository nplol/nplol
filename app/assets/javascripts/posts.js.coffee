$ ->

  # meme form loading
  $('.post-type').on 'change', (event) ->

    $.ajax({
      url: $(@).data('formPath'),
      type: 'post',
      data:  { 'post[type]': $(@).val() } })
      .done( (html) ->
        renderForm(html)
      )
      .fail( -> failedToRenderForm()
      )

    renderForm = (html) ->
      $('#post-form').html(html)

    failedToRenderForm = ->
      console.log('Failed to load post form.')


  $('.asset').each (index, element) ->

    $(element).tipsy({fallback: 'Click to see image URL', fade: true})

    $(element).on 'click', ->
      changeActiveAsset($(@))
      $('.asset-url').val($(@).attr('src'))
      $('.remove-asset').data('assetId', $(@).attr('data-asset-id'))

    $('.remove-asset').on 'click', ->
      $(".asset[data-asset-id=#{$(@).data('assetId')}]").remove()
      $('.asset-url').val('')

  changeActiveAsset = ($asset) ->
      $('.asset.active').removeClass('active')
      $asset.addClass('active')

  $('.add-asset').on 'ajax:success', (event, html) ->
    addAssetForm(html)

  addAssetForm = (html) ->
    dim(true)
    $('.dim').append(html)

  dim = (lightSwitch) ->
    prependDimmer() unless $('.dim').length > 0
    if lightSwitch then $('.dim').fadeIn('fast') else $('.dim').fadeOut('fast')

  prependDimmer = ->
    $('#main').prepend('<div class="dim"></div>')


