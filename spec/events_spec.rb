require 'rails_helper'
require 'helpers/events_helper'

RSpec.configure do |c|
  c.include EventsHelper
end

describe EventsController, type: :controller do

  context 'daily' do

    before :all do
      create :user_with_daily_events
    end

    before :each do
      login_user
    end

    it 'lists all relevant events' do
      get :index
      expect(assigns(:events)).to eq(current_user.events)
    end

  end

end
