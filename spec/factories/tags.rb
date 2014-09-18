FactoryGirl.define do

  factory :tag do
    post
    sequence(:name) { |n| "tag number #{n}" } 
  end

end
