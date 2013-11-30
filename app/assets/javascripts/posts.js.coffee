$(document).ready ->
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

  # Adding a new Asset field to the form.
  $('#add-asset-link').on 'click', (e) ->
    e.preventDefault()

    $.ajax(@.href)
    .done( (html) ->
        addAsset(html)
      )
    .fail( ->
        failedToAddAsset()
      )

  addAsset = (html) ->
    $(html).insertAfter('.form-input:last')

  failedToAddAsset = ->
    console.log 'Failed to load asset template :-('

  updateCross = ($element) ->
    $cross = $('#cross')
    $cross.offset( { top: $element.offset().top, left: $element.offset().left } )
    $cross.show()

  hideCross = ->
    $('#cross').hide()