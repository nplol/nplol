require 'rails_helper'

describe LikesController do
  let(:likeable_post) { create :post }
  let(:user) { User.first } 

  context 'logged in' do
    before :example do
      user = create :user
      session[:user_id] = user.uuid
    end

    it 'creates a new like for a post' do
      post :create, post_id: likeable_post.to_param
      expect(likeable_post.likes.length).to eq(1)
    end

    it 'doesn\'t allow for a user to like the same post twice' do
      user.like(likeable_post)
      post :create, post_id: likeable_post.to_param
      expect(likeable_post.likes.length).to eq(1)
      expect(response.status).to eq(401) 
    end
  end

  context 'not logged in' do
    it 'redirects to the root_url' do
      post :create, post_id: likeable_post.to_param
      expect(response).to redirect_to(root_url)
    end
  end

end
