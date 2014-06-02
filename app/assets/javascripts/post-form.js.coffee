class PostForm

  constructor: ->
    @has_assets = $('.asset').length > 0
    @$el = $('#assets')
    @_setupTipsy()
    @initBindings()
    @$dim = $('.dim')

  initBindings: ->
    $('#add_asset').on 'ajax:success', (event, html) =>
      @_dim(true)
      @assetForm = new AssetForm(html)
      @initEvents()

    if @has_assets
      $('.asset').each (index, element) =>
        @_configureAsset($(element))

    $('.remove-asset').on 'click', (event) =>
      $(event.delegateTarget).addClass('disabled').disabled = true
      return false unless $('.asset.active').length > 0
      asset_id = $('.asset.active').data('id')
      @_deleteAsset(asset_id)

  _setupTipsy: ->
    $('.remove-asset i').tipsy
      fade: true
      gravity: 'n'

    $('#add_asset i').tipsy
      fade: true
      gravity: 'w'

  _dim: (lightSwitch) ->
    @$dim.toggleClass('hidden', !lightSwitch)

  initEvents: ->
    @assetForm.on 'new_asset', (asset) =>
      @_dim(false)
      delete @assetForm
      @_handleAsset(asset)

    @assetForm.on 'close', =>
      @_dim(false)
      delete @assetForm

  _handleAsset: (asset) ->
    @$el.toggleClass('hidden') unless @has_assets
    @has_assets = true
    @_addAssetToPost(asset)
    $asset = @_addAssetToDOM(asset)
    @_configureAsset($asset)

  _addAssetToPost: (asset) ->
    $('<input>')
      .data('id', asset.id)
      .attr('type', 'hidden')
      .attr('name', 'post[asset_attributes][]')
      .val(asset.id)
      .appendTo $('#new_post')

  _addAssetToDOM: (asset) ->
    $('<img>')
      .attr('src', asset.thumb_url)
      .attr('title', 'Click to view URL')
      .data('large-url', asset.large_url)
      .data('id', asset.id)
      .addClass('asset')
      .appendTo @$el.find('.images')

  _configureAsset: ($asset) ->
    $asset
      .tipsy(fade: true, gravity: 'n')
      .on 'click', =>
        @_changeActiveAsset($asset)

  _changeActiveAsset: ($asset) ->
    $('.asset.active').removeClass('active')
    $asset.addClass('active')
    $('.asset-url').html($asset.data('large-url'))
    $('.remove-asset').removeClass('hidden')

  _deleteAsset: (asset_id) ->
    Q( $.ajax( url: "/assets/#{asset_id}", type: 'delete' )
    )
    .then(
      (data) =>
        $('.asset').filterByData('id', data.id).remove()
        $('input[name="post[asset_attributes][]"]').filterByData('id', data.id).remove()
        $('.asset-url').html('')
        @has_assets = $('.asset').length > 0
        @$el.toggleClass('hidden') unless @has_assets
        $('.remove-asset').addClass('hidden').removeClass('disabled').disabled = false
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

      $(document).on 'keydown', (event) =>
        @emit('close') if event.keyCode == 27

  @AssetForm = AssetForm

@PostForm = PostForm
