require 'rails_helper'
require 'helpers/omniauth_helper'

RSpec.configure do |c|
  c.include OmniauthHelper
end

describe SessionsController, type: :controller do

  describe 'user login through oauth' do

    before :all do
      OmniAuth.config.test_mode = true
    end

    before :each do
      mock_oauth_provider
    end

    it 'doesn\'t log in users with invalid credentials' do
      OmniAuth.config.mock_auth[:oauth_provider] = :invalid_credentials
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:oauth_provider]
      post :create, provider: :oauth_provider
      expect(User.all.length).to eq(0)
      expect(flash[:error]).to_not be_nil
      expect(@controller.current_user).to be_nil
    end

    it 'creates new user for first time login through oauth_provider' do
      expect(User.all.length).to eq(0)
      post :create, provider: :oauth_provider
      expect(User.all.length).to eq(1)
      expect(flash[:notice]).to_not be_nil
      expect(User.first.email).to eq('omar@baltimore.org')
      expect(@controller.current_user).to_not be_nil
    end

    it 'logs in previously established oauth users through oauth_provider' do
      omar = create :user
      oauth_auth = create :authentication, user: omar
      expect(User.all.length).to eq(1)
      expect(Authentication.all.length).to eq(1)
      expect(oauth_auth.user).to eq(omar)

      post :create, provider: :oauth_provider
      expect(User.all.length).to eq(1)
      expect(@controller.current_user).to eq(omar)
    end

  end

  describe 'user logout' do

    it 'logs the user out' do
      post :create, provider: :oauth_provider
      get :destroy
      expect(@controller.current_user).to be_nil
    end

  end

end
