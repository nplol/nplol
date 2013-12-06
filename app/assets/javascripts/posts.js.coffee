$ ->
  $('.asset').each (index, element) ->

    # Setup for Zeroclipboard
    _defaults = {
    title: 'Copy asset URL',
    copied_hint: 'Copied!',
    }

    clip = new ZeroClipboard( $(element) )

    clip.on 'load', (client, args) ->
      $(clip.htmlBridge).tipsy( { fade: true } )
      $(clip.htmlBridge).attr('title', _defaults.title);

    clip.on 'complete', (client, args) ->
      $(clip.htmlBridge)
      .attr('title', _defaults.copied_hint)
      .tipsy('show')

    clip.on 'mouseout', ->
      $(clip.htmlBridge).attr('title', _defaults.title)
      $('.tipsy').remove()
      hideCross()

    $(element).on 'mouseover', ->
      updateCross($(@))

    updateCross = ($element) ->
      $cross = $('#cross')
      $cross.attr('data-asset-id', $element.attr('data-asset-id'))
      $cross.offset( { top: $element.offset().top, left: $element.offset().left-50 } )
      #    $cross.offset( { top: 50, left: 50 } )
      $cross.show()

    hideCross = ->
  #    $('#cross').hide()

    $('#cross').on 'click', ->
      $(".asset[data-asset-id=#{$(@).attr('data-asset-id')}]").remove()

    $('#show-asset-form').on 'click', (e) ->
      e.preventDefault()
      $('#assets-form').fadeIn('fast')
