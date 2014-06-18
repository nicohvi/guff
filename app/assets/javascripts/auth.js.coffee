class Auth

  constructor: ->
    @githubAuth = new GithubAuth()
    @googleAuth = new GoogleAuth()

  class GithubAuth

    constructor: ->
      @url = '/auth/github'
      @initBindings()

    initBindings: ->
      $('.github-login').on 'click', (event) =>
        event.preventDefault()

        params = 'location=0,status=0,width=800,height=600'
        githubWindow = window.open(@url, 'githubWindow', params)
        githubWindow.focus()

  @GitHubAuth = GithubAuth

  class GoogleAuth

    constructor: ->
      @url = '/auth/google_oauth2'
      @initBindings()

    initBindings: ->
      $('.google-login').on 'click', (event) =>
        event.preventDefault()

        params = 'location=0,status=0,width=800,height=600'
        googleWindow = window.open(@url, 'googleWindow', params)
        googleWindow.focus()

  @GoogleAuth = GoogleAuth

@Auth = Auth
