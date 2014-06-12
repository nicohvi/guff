FactoryGirl.define do
  
  factory :user do
    username 'omar'
    email 'omar@baltimore.org'

    factory :invalid_user do
      email: ''
    end
  end

end
