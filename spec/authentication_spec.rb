require 'rails_helper'

describe SessionsController, type: :controller do

  describe 'user login through oauth' do

    before :all do
      OmniAuth.config.test_mode = true
    end

    context 'google' do

      before :each do
        OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
          provider: 'google',
          uid: '123545'
        })
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
      end

      it 'shows error message when login is unsuccessfull' do
        OmniAuth.config.mock_auth[:google] = :invalid_credentials
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
        post :create, provider: :google
        expect(User.all.length).to eq(0)
        expect(flash[:error]).to_not be_nil
      end

      it 'creates new user for first time login through google' do
        post :create, provider: :google
      end


    end

    context 'github' do

    end

  end

end
