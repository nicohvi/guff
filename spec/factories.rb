FactoryGirl.define do

  factory :user, aliases: [:host] do
    username 'omar'
    email 'omar@baltimore.org'
    image 'fake-url.png'

    factory :invalid_user do
      email ''
    end

  end

  factory :authentication do
    user
    uid 'googleuid123'
    provider 'oauth_provider'
  end

  factory :event do
    host
    name 'dummy-event'

    factory :invalid_event do
      begins_at Date.tomorrow
      ends_at Date.today
    end

  end

end
