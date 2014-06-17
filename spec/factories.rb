FactoryGirl.define do

  factory :user, aliases: [:host] do
    username 'omar'
    email 'omar@baltimore.org'
    image 'fake-url.png'

    factory :invalid_user do
      email ''
    end

    factory :user_with_daily_events do
      ignore do
        events_count Random.rand(1..10)
      end

      after(:create) do |user, evaluator|
        create_list(:attended_event, evaluator.events_count,
          { host: user, begins_at: Date.today.to_datetime,
            ends_at: Date.today.end_of_day - evaluator.events_count.hours })
      end

    end
  end

  factory :authentication do
    user
    uid 'googleuid123'
    provider 'oauth_provider'
  end

  factory :event, aliases: [:attended_event] do
    name 'dummy-event'
    begins_at Date.today.to_datetime
    ends_at Date.today.end_of_day
  end

end
