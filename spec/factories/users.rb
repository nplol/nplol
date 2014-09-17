FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user-#{n}@nplol.com" }
    name 'Frank'
    avatar 'image.png'

    factory :nplol_user do
      role 'nplol'
    end

  end

end
