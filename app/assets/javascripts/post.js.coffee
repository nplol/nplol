class Post

  constructor: ->
    @comments = $('.comments')
    @comment_form = $('#new_comment')
    @initBindings()

  initBindings: ->
    $(document).on 'ajax:success', '#new_comment', (event, html, status) =>
      @comment_form.find('input[type=text]').val('')
      @comments.prepend(html)

    $(document).on 'ajax:success', '#like_post', (event, json, status) ->
      $(@).find('i')
        .removeClass('fa-heart-o')
        .addClass('fa-heart liked')
      $(@).find('span').text(json.likes)

@Post = Post
