FactoryGirl.define do

  factory :comment do
    user
    post
    text 'This is totally a comment, I swear.'
  end

end
