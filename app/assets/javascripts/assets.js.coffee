$ ->

  window.addListenersToAssetForm = ->
    debugger
    $('#new_asset').on 'ajax:beforeSend', (event, xhr, settings) ->
      $(@).find('input[name=commit]').val('Submitting image').addClass('disabled')

    $('#new_asset').on 'ajax:success', (event, data, status, xhr) ->
      existingAssets = $('.asset').length > 0

      # append new asset to the DOM
      $('.assets .images').append(xhr.responseText)

      # wrap the new asset as a jQuery object
      $asset = $('.asset:last')

      addAssetToPost($asset)
      configureAsset($asset)

      showAssetsAndTools() unless existingAssets

      dim(false)

    $('#new_asset').on 'ajax:error', (event, xhr, status, error) ->
      $('.dim').html(xhr.responseText)

  showAssetsAndTools = ->
    $('.assets').removeClass('hidden')
    $('.asset-tools').removeClass('hidden')

  hideAssetsAndTools = ->
    $('.assets').addClass('hidden')
    $('.asset-tools').addClass('hidden')

  addAssetToPost = ($asset) ->
    input = $("<input>")
      .attr("type", "hidden")
      .attr("name", "post[asset_attributes][id]").val($asset.data('asset-id'));
    $('form:last').append($(input))

  # iterate over each asset and add respective handlers and tooltips.
  $('.asset').each (index, element) ->
    configureAsset($(element))

  configureAsset = ($asset) ->
    $asset.tipsy({fallback: 'Click to see image URL', fade: true})

    $asset.on 'click', ->
      changeActiveAsset($(@))
      $('.asset-url').val($(@).attr('src'))
      $('.remove-asset').data('assetId', $(@).attr('data-asset-id'))

  changeActiveAsset = ($asset) ->
    $('.asset.active').removeClass('active')
    $asset.addClass('active')

  $('.remove-asset').on 'click', ->
    $asset = $(".asset[data-asset-id=#{$(@).data('assetId')}]")
    deleteAsset($asset)

  deleteAsset = ($asset) ->
    $.ajax({
      url: "/assets/#{$asset.attr('data-asset-id')}",
      type: 'delete' })
    .done( (html) ->
        $asset.remove()
        $('.asset-url').val('')
        hideAssetsAndTools()
      )
