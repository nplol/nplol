$ ->
  $.fn.filterByData = (property, value) ->
    @filter -> $(@).data(property) == value
