$(document).ready ->
  $('.asset').each (index, element) ->

      _defaults = {
      title: 'copy to clipboard',
      copied_hint: 'copied!',
      gravity: 'n'
      }

      clip = new ZeroClipboard( $(element) )

      clip.on 'load', ->
        $(clip.htmlBridge).tipsy( { gravity: _defaults.gravity } )
        $(clip.htmlBridge).attr('title', _defaults.title);

      clip.on 'complete', (client, args) ->
        copied_hint = $(@).data('copied-hint')
        if(!copied_hint)
          copied_hint = _defaults.copied_hint
        $(clip.htmlBridge)
        .prop('title', copied_hint)
        .tipsy('show')