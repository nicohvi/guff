class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    flash[:error] = t('user.already_logged_in') if current_user
    flash[:error] = t('user.login_failure') unless auth_hash.is_a?(Hash)
    return render nothing: true, status: 401 if flash[:error]

    authentication = Authentication.find_by(provider: auth_hash[:provider],
      uid: auth_hash[:uid])

    if authentication
      session[:user_id] = authentication.user.id
    else
      # see if there already exists an user using the same email
      user = User.find_by(email: auth_hash[:email])
      if user
        user.authentications.create(provider: auth_hash[:provider],
         uid: auth_hash[:uid])
      else
        auth_hash[:user] = auth_hash.delete :info
        user = User.create(user_params(auth_hash[:user].symbolize_keys!))
      end
    session[:user_id] = user.id
    end
    flash[:notice] = t('user.login_success', provider: auth_hash[:provider])
    render nothing: true, status: 200
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def user_params(auth_hash)
    auth_hash.select { |key,_| %w(image email).include? key }
  end

end
