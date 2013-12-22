$ ->

  $('#new_comment').on 'ajax:success', (event, html) ->
    $('#comments').append(html)
    clearAssetForm($(@))

  $('#new_comment').on 'ajax:error', (ecent, xhr, status, error) ->
    $(@).html(xhr.responseText)

  clearAssetForm = ($form) ->
    $form.find('input[type=file]').val('')
    $form.find('.error').remove()