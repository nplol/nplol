FactoryGirl.define do
  
  factory :post do
    title "MyString"
    content "MyText"
  end

  factory :invalid_post, parent: :post do
  	title 'inv1'
  	content ''
  end

end