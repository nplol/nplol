require 'fileutils'

FactoryGirl.define do

  sequence :title do |n|
    "Hunting dat whale for the #{n}th time"
  end

  factory :post do
    title
    content 'Ahab\'s mission was null and void.'
    image_file_name { 'test.jpg' }
    image_content_type { 'image/jpeg' }
    image_file_size { 256 }

    factory :public_post do
      public true
    end

    factory :private_post do
      public false
    end

  end

end
