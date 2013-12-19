require 'spec_helper'

describe Post do

	before(:each) do
    @post = build(:post)
    @invalid_post = build(:invalid_post)
  end

  it 'is valid with title and boby' do
    @post.should be_valid
  end

  it 'is not valid with an empty title' do
    @invalid_post.should_not be_valid
  end

end