$(document).ready ->
  $('.asset').each (index, element) ->
    $(element).hover(toggle($('.tooltip')), toggle($('.tooltip')))


toggle = (elem) ->
  $(elem).toggle('fast')