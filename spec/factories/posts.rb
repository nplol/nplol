require 'fileutils'

FactoryGirl.define do

  sequence :title do |n|
    "Hunting dat whale for the #{n}th time"
  end

  factory :post do
    title
    image_file_name { 'test.jpg' }
    image_content_type { 'image/jpeg' }
    image_file_size { 256 }

    trait :public do
      public true
    end

    trait :private do
      public false
    end

    factory :popular_post do
      after :create do |post|
        create_list(:comment, 5, post: post)
      end
    end

  end


end
