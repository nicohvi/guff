module EventsHelper

  def login_user
    allow(@controller).to receive(:current_user).and_return(User.last)
  end

  def current_user
    @controller.current_user
  end

end
