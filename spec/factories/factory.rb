FactoryGirl.define do
  
  factory :post do
    title "Hunting dat whale"
    content "Ahab's mission was null and void."
  end

  factory :invalid_post, parent: :post do
  	title 'inv1'
  	content ''
  end

end