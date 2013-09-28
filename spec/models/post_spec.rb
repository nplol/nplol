require 'spec_helper'

describe Post do

	before(:each) do
    @post = build(:post)
  end

  it "is valid with title and boby" do
    @post.should be_valid
  end

  it "is not valid with an empty title" do
    @post.title = nil
    @post.should_not be_valid
  end

end