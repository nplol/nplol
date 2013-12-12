$ ->
  $container = $('#posts')

  height = $(window).height() - 100 +'px'

  $container.css('height', height)

  $container.packery {
    itemSelector: '.post',
    gutter: 20,
    isHorizontal: true
  }


