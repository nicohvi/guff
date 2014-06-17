module EventsHelper

  def login_user
    begin
      @controller.current_user = User.last
    rescue
      p 'No @controller defined - are you using a controller spec?'
    end
  end

end
