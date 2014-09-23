class CommentHandler

  constructor: ->
    @el = $('.comments')
    @form = $('#new_comment')
    @initBindings()

  initBindings: ->
    $(document).on 'ajax:success', '#new_comment', (event, html, status) =>
      @form.find('input[type=text]').val('')
      @el.prepend(html)

@CommentHandler = CommentHandler
