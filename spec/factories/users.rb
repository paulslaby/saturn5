FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "joe#{n}@example.com" }
    password         'joesthebest'

    trait :with_billapp_credentials do
      billapp_login 'paul.slaby@seznam.cz'
      billapp_password 'asdfgh'
      billapp_agenda 'kanibal'
    end
  end
end
