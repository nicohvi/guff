FactoryGirl.define do

  factory :user do
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

end
