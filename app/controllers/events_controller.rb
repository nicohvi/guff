class EventsController < ApplicationController

  before_filter :authenticate_user

  def index
    @events = current_user.events.send(params[:scope])
  end

end
