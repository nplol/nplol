require 'rails_helper'

describe GridHelper do
  let(:posts) { Post.all }

  before :all do
    create_list :post, 10
  end

  describe 'score' do
    it 'calcuates average score when there are no popular posts' do
      score(posts)
      expect(posts.select { |post| post.popular }.length).to eq(0)
    end

    it 'calcuates average score when there are popular posts' do
      create :post, :popular
      score(posts)
      expect(posts.select { |post| post.popular }.length).to eq(1)
    end

  end

  describe 'gridify' do
    before :all do
      create_list :post, 5, :popular
    end

    it 'sets grid correctly for popular and regular posts' do
      score(posts)
      gridify(posts)
      expect(posts[0].popular).to_not be_truthy
      expect(posts[1].popular).to     be_truthy
      expect(posts[2].popular).to_not be_truthy
      expect(posts[3].popular).to     be_truthy
      expect(posts[4].popular).to_not be_truthy
      expect(posts[5].popular).to     be_truthy
    end
  end

end
