class PostForm

  constructor: ->
    @has_assets = $('.asset').length > 0
    @initBindings()

  initBindings: ->
    $('#add_asset').on 'ajax:success', (event, html) =>
      app.emit('dim', true)
      @assetForm = new AssetForm(html)
      @initEvents()

    if @has_assets
      $('.asset').each (index, element) =>
        @_configureAsset($(element))

    $('.remove-asset').on 'click', (event) =>
      asset_id = $('.asset.active').data('id')
      @_deleteAsset(asset_id)

  initEvents: ->
    @assetForm.on 'new_asset', (asset) =>
      app.emit('dim', false)
      delete @assetForm
      @_handleAsset(asset)

  _handleAsset: (asset) ->
    @_toggleAssetsAndTools() unless @has_assets
    @has_assets = true
    @_addAssetToPost(asset)
    $asset = @_addAssetToDOM(asset)
    @_configureAsset($asset)

  _addAssetToPost: (asset) ->
    $('<input>')
      .attr('type', 'hidden')
      .attr('name', 'post[asset_attributes][]')
      .val(asset.id)
      .appendTo $('#new_post')

  _toggleAssetsAndTools: ->
    $('.assets').toggleClass('hidden')
    $('.asset-tools').toggleClass('hidden')

  _addAssetToDOM: (asset) ->
    $asset = $('<img>')
                .attr('src', asset.thumb_url)
                .attr('title', 'Click to view URL')
                .data('large-url', asset.large_url)
                .data('id', asset.id)
                .addClass('asset')
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

  _deleteAsset: (asset_id) ->
    Q( $.ajax( url: "/assets/#{asset_id}", type: 'delete' )
    )
    .then(
      (data) =>
        $('.asset').filterByData('id', data.id).remove()
        $('.asset-url').val('')
        @has_assets = $('.asset').length > 0
        @_toggleAssetsAndTools() unless @has_assets
    )
    .fail(
      (error) ->
        console.log 'Failed to delete asset.'
    )

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
