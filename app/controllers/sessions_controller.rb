class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    if current_user
      flash[:error] = t('user.already_logged_in')
    end
    unless auth_hash.is_a?(Hash)
      flash[:error] = t('user.login_failure')
    end
    return render nothing: true, status: 401 if flash[:error]
    options = user_params(auth_hash)
    user = User.from_provider(options)
    # session[:user_id] = user.id
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def user_params(auth_hash)
    # split due to naming for google_oauth
    token_prefix = "#{auth_hash['provider'].split('_').first}_auth_token"

    options = auth_hash.select{ |key, value| %w(info credentials).include? key }['info'].merge(auth_hash['credentials']).select { |key, value| %(name image email token).include? key }.symbolize_keys!

    options[:avatar] = options[:image]
    options[token_prefix.to_sym] = options[:token]
    options.delete(:image)
    options.delete(:token)

    options
  end

end
