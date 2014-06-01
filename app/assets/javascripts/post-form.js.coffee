class PostForm

  constructor: ->
    @initBindings()

  initBindings: ->
    $('#add_asset').on 'ajax:success', (event, html) =>
      app.emit('dim', true)
      @assetForm = new AssetForm(html)
      @initEvents()

  initEvents: ->
    @assetForm.on 'new_asset', (asset) =>
      app.emit('dim', false)
      delete @assetForm
      @_handleAsset(asset)

  _handleAsset: (asset) ->
    @_showAssetsAndTools() unless $('.asset').length > 0
    @_addAssetToPost(asset)
    $asset = @_addAssetToDOM(asset)
    @_configureAsset($asset)
    debugger

  _addAssetToPost: (asset) ->
    $('<input>')
      .attr('type', 'hidden')
      .attr('name', 'post[asset_attributes][]')
      .val(asset.id)
      .appendTo $('#new_post')

  _showAssetsAndTools: ->
    $('.assets').fadeIn('fast')
    $('.asset-tools').fadeIn('fast')

  _addAssetToDOM: (asset) ->
    $asset = $('<img>')
                .attr('src', asset.thumb_url)
                .attr('title', 'Click to view URL')
                .data('large-url', asset.large_url)
                .data('id', asset.id)
                .appendTo $('.assets .images')

  _configureAsset: ($asset) ->
    $asset
      .tipsy(fade: true, gravity: 'n')
      .on 'click', =>
        @_changeActiveAsset($asset)

  _changeActiveAsset: ($asset) ->
    $('.asset.active').removeClass('active')
    $asset.addClass('active')
    $('.asset-url').val($asset.data('large-url'))
    $('.remove-asset').data('asset-id', $asset.data('id'))

  class AssetForm extends EventEmitter

    constructor: (html) ->
      $('.dim').html(html)
      @initBindings()

    initBindings: ->
      $('#asset_image').fileupload
        dataType: 'json'
        done: (e, data) =>
          @emit('new_asset', data.result )

  @AssetForm = AssetForm

@PostForm = PostForm
