module EventsHelper

  def login_user(user)
    allow(@controller).to receive(:current_user).and_return(user)
  end

  def current_user
    @controller.current_user
  end

  def host_events(host, start)
    Random.rand(2..10).times do
      create :event,
        { host: host, begins_at: start,
          ends_at: start + 6.hours }
    end
  end

  def attend_events(host, guest)
    host.events.each do |event|
      guest.attend(event)
    end
  end

end
