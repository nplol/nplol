FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user-#{n}@nplol.com" }
    sequence(:username) { |n| "user-#{n}" }
    name 'Frank'
    avatar 'image.png'

    trait :nplol do
      role 'nplol'
    end
  end
end
