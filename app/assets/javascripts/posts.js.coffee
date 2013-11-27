$(document).ready ->
  $('.asset').each (index, element) ->

      _defaults = {
      title: 'Copy asset URL',
      copied_hint: 'Copied!',
      }

      clip = new ZeroClipboard( $(element) )

      clip.on 'load', ->
        $(clip.htmlBridge).tipsy( { fade: true } )
        $(clip.htmlBridge).attr('title', _defaults.title);

      clip.on 'complete', (client, args) ->
        $(clip.htmlBridge)
        .attr('title', _defaults.copied_hint)
        .tipsy('show')

      clip.on 'mouseout', ->
        $(clip.htmlBridge).attr('title', _defaults.title)
        $('.tipsy').remove()
