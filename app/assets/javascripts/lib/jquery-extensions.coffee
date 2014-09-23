$ ->
  $.fn.filterByData = (property, value) ->
    @filter -> $(@).data(property) == value

  $.fn.swap = ($to) ->
    target = $to.clone(true)
    $to.replaceWith(@)
    $(@).replaceWith(target)
