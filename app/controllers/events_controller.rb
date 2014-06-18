class EventsController < ApplicationController

  before_filter :authenticate_user

  def index
    params[:scope] ||= 'daily'
    @events = current_user.events.send(params[:scope])
    @attended_events = current_user.attended_events.send(params[:scope])
  end

end
