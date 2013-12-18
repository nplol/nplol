$ ->

  console.log($('#new_comment').length)

  $('#new_comment').on 'ajax:success', (event, html) ->
    $('#comments').append(html)
    clearCommentsForm($(@))

  $('#new_comment').on 'ajax:error', (e, xhr, status, error) ->
    $(@).html(xhr.responseText)

  clearCommentsForm = ($form) ->
    $form.find('input[type=text], textarea').val('')
    $form.find('.error').remove()