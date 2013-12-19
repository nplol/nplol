FactoryGirl.define do

  sequence :title do |n|
    "Hunting dat whale for the #{n}th time"
  end
  
  factory :post do
    title
    content 'Ahab\'s mission was null and void.'
    published true
  end

  factory :invalid_post, parent: :post do
  	title ''
  	content ''
  end

end