$ ->

  $.fn.extend
    wrapped: ->
      @.parent('.row').length > 0
