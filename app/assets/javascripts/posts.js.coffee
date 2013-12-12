$ ->

  # meme form loading
  $('.post-type').on 'change', (event) ->
    post_type = $(@).val()
    renderMemeForm() if post_type == 'Meme'
    renderPostForm() if post_type == 'Normal'

  renderPostForm = () ->
    hideMemeForm()
    $('.form-input').fadeIn('fast')
    $('.assets').fadeIn('fast')
    $('.asset-tools').fadeOut('fast')

  renderMemeForm = () ->
    hidePostForm()

  hidePostForm = () ->
    $('label[for="post_content"]').parent('.form-input').fadeOut('fast')
    $('.assets').fadeOut('fast')
    $('.asset-tools').fadeOut('fast')

  hideMemeForm = () ->


  $('.asset').each (index, element) ->

    $(element).tipsy({fallback: 'Click to see image URL', fade: true})

    $(element).on 'click', ->
      changeActiveAsset($(@))
      $('.asset-url').val($(@).attr('src'))
      $('.remove-asset').data('assetId', $(@).attr('data-asset-id'))

    $('.remove-asset').on 'click', ->
      $(".asset[data-asset-id=#{$(@).data('assetId')}]").remove()
      $('.asset-url').val('')

    $('#show-asset-form').on 'click', (e) ->
      e.preventDefault()
      $('#assets-form-background').fadeIn('fast')

    changeActiveAsset = ($asset) ->
      $('.asset.active').removeClass('active')
      $asset.addClass('active')