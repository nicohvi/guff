module OmniauthHelper
  def mock_oauth_provider
    OmniAuth.config.mock_auth[:oauth_provider] = OmniAuth::AuthHash.new({
      provider: 'oauth_provider',
      uid: 'googleuid123',
      info: {
        email: 'omar@baltimore.org',
        image: 'fake-url.png'
      },
      credentials: {
        token: 'token'
      }
    })
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:oauth_provider]
  end
end
