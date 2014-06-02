# class AssetForm
#
#   constructor: (html) ->
#     $('.dim').html(html)
#     @$el = $('#asset-container')
#     @initBindings()
#
#   initBindings: ->
#     $('#asset_image').fileupload
#       dataType: 'json'
#       done: (e, data) =>
#         @$el.trigger $.Event('new_asset', { asset: data.result } )
#
# @AssetForm = AssetForm

# $ ->

  # # needs to be made global so that it can be called from posts.js.coffee
  # @addListenersToAssetForm = ->
  #   $('#new_asset').on 'ajax:beforeSend', (event, xhr, settings) ->
  #     $(@).find('input[name=commit]').val('Submitting image').addClass('disabled')
  #
  #   $('#new_asset').on 'ajax:success', (event, data, status, xhr) ->
  #     showAssetsAndTools() unless existingAssets()
  #
  #   # append new asset to the DOM
  #     $('.assets .images').append(xhr.responseText)
  #
  #     # wrap the new asset as a jQuery object
  #     $asset = $('.asset:last')
  #
  #     addAssetToPost($asset)
  #     configureAsset($asset)
  #
  #     dim(false)
  #
  #   $('#new_asset').on 'ajax:error', (event, xhr, status, error) ->
  #     $(@).html(xhr.responseText)
  #
  # showAssetsAndTools = ->
  #   $('.assets').fadeIn('fast')
  #   $('.asset-tools').fadeIn('fast')
  #
  # hideAssetsAndTools = ->
  #   $('.assets').fadeOut('fast')
  #   $('.asset-tools').fadeOut('fast')
  #
  # existingAssets = ->
  #   $('.asset').length > 0
  #
  # addAssetToPost = ($asset) ->
  #   input = $("<input>")
  #     .attr("type", "hidden")
  #     .attr("name", "post[asset_attributes][]").val($asset.data('asset-id'));
  #   $('form:last').append($(input))
  #
  # configureAsset = ($asset) ->
  #   $asset.tipsy({fallback: 'Click to see image URL', fade: true})
  #
    # $asset.on 'click', ->
    #   changeActiveAsset($(@))
    #   $('.asset-url').val($(@).attr('data-large-url'))
      # $('.remove-asset').data('assetId', $(@).attr('data-asset-id'))
  #
  # changeActiveAsset = ($asset) ->
    # $('.asset.active').removeClass('active')
  #   $asset.addClass('active')
  #
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
        $("input[value=#{$asset.attr('data-asset-id')}]").remove()
        hideAssetsAndTools() unless existingAssets()
      )
  #
  # # iterate over each asset and add respective handlers and tooltips.
  # $('.asset').each (index, element) ->
  #   configureAsset($(element))
