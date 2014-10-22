class Grid

  constructor: ->
    @posts = $('.grid-item')
    @set()

  set: ->
    _.map @posts, (post) => @setRow(post)

  setRow: (post) ->
    $post = $(post)
    index = _.indexOf(@posts, post)
    return if $post.wrapped()
    rowStart = @findRowStart($post, index)
    @createRow(rowStart)

  createRow: (start) ->
    posts = []
    posts.push @posts[start]
    posts.push @posts[start+1] 
    posts.push @posts[start+2] unless $(posts[0]).hasClass('big') || $(posts[1]).hasClass('big')

    $(posts).wrapAll('<section class="row">')

  findRowStart: ($post, index) ->
    return index if index == 0
    prev = $(@posts[index-1])
    if prev.wrapped()
      return index 
    else
      return @findRowStart(prev, --index)

@Grid = Grid
