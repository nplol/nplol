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

    trait :popular do
      after :create do |post|
        create_list(:comment, 5, post: post)
      end
    end

    factory :post_with_tags do
      after :create do |post|
        tags = Tag.all
        post.tags << tags
        post.save
      end
    end

  end


end
