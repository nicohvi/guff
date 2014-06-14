require 'rails_helper'

describe SessionsController, type: :controller do

  describe 'user login through oauth' do

    before :all do
      OmniAuth.config.test_mode = true
    end

    context 'google' do

      before :each do
        OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
          provider: 'twitter',
          uid: '123545'
        })
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
      end

      it 'shows error message when login is unsuccessfull' do
        OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
      end


    end

    context 'github' do

    end

  end

end
