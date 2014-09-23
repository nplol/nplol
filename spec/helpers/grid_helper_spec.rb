require 'rails_helper'

describe GridHelper do
  let(:posts) { Post.all }

  before :all do
    10.times { create :post }
  end

  describe 'score' do
    it 'calcuates average score when there are no popular posts' do
      score(posts)
      expect(posts.select { |post| post.popular? }.length).to eq(0)
    end

    it 'calcuates average score when there are popular posts' do
      create :popular_post
      score(posts)
      expect(posts.select { |post| post.popular? }.length).to eq(1)
    end

  end

  describe 'gridify' do
    before :all do
      5.times { create :popular_post }
    end

    it 'sets grid correctly for popular and regular posts' do
      score(posts)
      gridify(posts)
      expect(posts.first.popular?).to_not be_truthy
      expect(posts.second.popular?).to be_truthy
      expect(posts.third.popular?).to be_truthy
      expect(posts.fourth.popular?).to_not be_truthy
    end
  end

end
