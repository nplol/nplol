# class AssetManager
#
#   constructor: ->
#
#   handleAsset: (asset) ->
#     asset = event.asset
#     @_showAssetsAndTools() unless $('.asset').length > 0
#     @_addAssetToPost(asset)
#     $asset = @addAssetToDOM(asset)
#     @_configureAsset($asset)
#
#   _addAssetToPost: (asset) ->
#     $('<input>')
#       .attr('type', 'hidden')
#       .attr('name', 'post[asset_attributes][]')
#       .val(asset.id)
#       .appendTo $('#new_post')
#
#   _showAssetsAndTools: ->
#     $('.assets').fadeIn('fast')
#     $('.asset-tools').fadeIn('fast')
#
#   _addAssetToDOM: (asset) ->
#     $asset = $('<img>')
#                 .attr('src', asset.thumb_url)
#                 .attr('title', 'Click to view URL')
#                 .data('large-url', asset.large_url)
#                 .data('id', asset.id)
#                 .appendTo $('.assets .images')
#
#   _configureAsset: ($asset) ->
#     $asset
#       .tipsy(fade: true, gravity: 'n')
#       .on 'click', =>
#         @_changeActiveAsset($asset)
#
#   _changeActiveAsset: ($asset) ->
#     $('.asset.active').removeClass('active')
#     $asset.addClass('active')
#     $('.asset-url').val($asset.data('large-url'))
#     $('.remove-asset').data('asset-id', $asset.data('id'))
