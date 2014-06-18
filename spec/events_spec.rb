require 'rails_helper'
require 'helpers/events_helper'

RSpec.configure do |c|
  c.include EventsHelper
end

describe Event do

  it 'doesn\'t allow events with begins_at later than ends_at' do
    event = build :invalid_event
    expect(event).to_not be_valid
    expect(event.errors.messages[:begins_at]).to_not be_nil
  end

  it 'doesn\'t allow events to take place in the past' do
    event = build :invalid_event, begins_at: Date.yesterday
    expect(event).to_not be_valid
    expect(event.errors.messages[:begins_at]).to_not be_nil
  end

end

describe EventsController, type: :controller do

  let(:omar) { create :user }
  let(:avon) { create :user, { username: 'avon', email: 'avon@barksdale.com' } }

  before :each do
    login_user(omar)
  end

  it 'lists attended events' do
    host_events(avon, Date.today)
    attend_events(avon, omar)
    get :index
    expect(omar.attended_events.many?).to eq(true)
    expect(assigns(:attended_events)).to eq(current_user.attended_events.daily)
  end

  context 'daily' do

    it 'lists all daily events' do
      host_events(omar, Date.today)
      get :index, scope: 'daily'
      expect(omar.events.daily.many?).to eq(true)
      expect(assigns(:events)).to eq(current_user.events.daily)
    end

  end

  context 'weekly' do

    it 'lists weekly events rather than daily' do
      host_events(omar, Date.tomorrow)
      host_events(omar, Date.today)
      get :index, scope: 'weekly'
      expect(omar.events.weekly.many?).to eq(true)
      expect(assigns(:events)).to eq(current_user.events.weekly)
      expect(current_user.events.weekly.length).to be > current_user.events.daily.length
    end

  end

  context 'monthly' do

    it 'lists monthly events rather than weekly' do
      host_events(omar, Date.tomorrow)
      host_events(omar, Date.today.next_week)
      get :index, scope: 'monthly'
      expect(omar.events.monthly.many?).to eq(true)
      expect(assigns(:events)).to eq(current_user.events.monthly)
      expect(current_user.events.monthly.length).to be > current_user.events.weekly.length
    end

  end

end
