FactoryGirl.define do
  
  factory :identity do
    sequence(:uid) { |n| "123#{n}" }
    provider 'google'
  end

end
