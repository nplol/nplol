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
      expect(posts[0].popular?).to be_truthy
      expect(posts[1].popular?).to_not be_truthy
      expect(posts[2].popular?).to_not be_truthy
      expect(posts[3].popular?).to be_truthy
      expect(posts[4].popular?).to be_truthy
      expect(posts[5].popular?).to_not be_truthy
    end
  end

end
