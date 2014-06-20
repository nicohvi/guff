class App extends EventEmitter

  constructor: ->
    @initBindings()
    @flash = $('#flash')

  initBindings: ->
    @.on 'load_auth', =>
      @auth = new Auth()

    @.on 'auth', =>
      delete @auth
      window.location = '/'

    @.on 'error', (error) =>
      $('<div>')
        .addClass('error')
        .html(error)
        .appendTo(@flash)

@App = App
