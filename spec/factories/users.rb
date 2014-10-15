FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user-#{n}@nplol.com" }
    name 'Frank'
    avatar 'image.png'

    trait :nplol do
      role 'nplol'
    end

    factory :user_with_identities do
      after :create do |user|
        create :identity, { uid: '123', provider: 'google', user: user }
        create :identity, { provider: 'github', user: user }
      end
    end

  end

end
