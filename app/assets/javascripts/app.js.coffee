class App extends EventEmitter

  constructor: ->
    @initBindings()

  initBindings: ->
    @.on 'load_auth', =>
      @auth = new Auth()

    $(window).on 'auth', =>

@App = App
