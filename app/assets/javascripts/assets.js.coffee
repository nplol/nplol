$ ->

  $('#new_asset').on 'ajax:beforeSend', (event, xhr, settings) ->
    $(@).find('input[name=commit]').val('Submitting image').addClass('disabled')

  $('#new_asset').on 'ajax:success', (event, data, status, xhr) ->
    dim(false)
    $('.assets').append(xhr.responseText)
    addAssetToPost()
    $('.assets').removeClass('hidden') if $('.assets').hasClass('hidden')

  $('#new_asset').on 'ajax:error', (event, xhr, status, error) ->
    $('.dim').html(xhr.responseText)

  addAssetToPost = ->
    input = $("<input>")
      .attr("type", "hidden")
      .attr("name", "post[asset_attributes]").val($('.asset:last').data('asset-id'));
    $('form:last').append($(input))