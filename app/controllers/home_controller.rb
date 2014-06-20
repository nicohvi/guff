class HomeController < ApplicationController

  before_filter :logged_in?

  def index

  end

  private

  def logged_in?
    redirect_to root_path if current_user
  end

end
