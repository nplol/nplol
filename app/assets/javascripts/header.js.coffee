$ =>

  class Header

    constructor: (html) ->
      @$el = $('header')
      $('.tipsy').remove()
      $('#user-menu').detach().appendTo('body')
      @initBindings()

    reload: (html) ->
      @$el.html(html)
      @toggle()

    initBindings: =>
      $('header i')
      .on 'click', ->
        $(@).tipsy 'hide'
      .tipsy {fade: true, gravity: 'n', block: -> !($('#user-menu').hasClass('active') && @$element.hasClass('fa-cog')) }

      $('.settings')
      .on 'click', =>
        @toggleMenu()

      $('.authorize').on 'click', =>
        @toggle()

      $('.authorize').on 'ajax:error', (xhr, status, error) =>
        @toggleMenu()
        @toggle()

      $('.authorize').on 'ajax:success', (event, html, xhr) =>
        $('#user-menu').remove()
        setTimeout( => @reload(html),
        800)

    toggleMenu: ->
      $('#user-menu').toggleClass('active')

    toggle: ->
      @$el.toggleClass('transition')

  @Header = new Header()
