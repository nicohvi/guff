class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    flash[:error] = t('errors.user.already_logged_in') if current_user
    flash[:error] = t('errors.user.login_failure') unless auth_hash.is_a?(Hash)
    return render 'partials/_close_window', layout: false if flash[:error]

    authentication = Authentication.find_by(provider: auth_hash[:provider],
      uid: auth_hash[:uid])

    if authentication
      session[:user_id] = authentication.user.id
    else
      # see if there already exists an user using the same email
      user = User.find_by(email: auth_hash[:info][:email])
      if user
        user.authentications.create(provider: auth_hash[:provider],
         uid: auth_hash[:uid])
      else
        auth_hash[:user] = auth_hash.delete :info
        user = User.create(user_params(auth_hash[:user].symbolize_keys!))
      end
    session[:user_id] = user.id
    end
    flash[:notice] = t('user.login_success')
    render 'partials/_close_window', layout: false
  end

  def destroy
    reset_session
    flash[:notice] = t('user.logout_success')
    redirect_to root_path
  end

  private

  def user_params(auth_hash)
    auth_hash.select { |key,_| %w(image email).include? key }
  end

end
