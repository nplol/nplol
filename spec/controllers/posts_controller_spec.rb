require 'rails_helper'

describe PostsController do
  let(:current_user) { create :user }
  let(:current_nplol_user) { create :nplol_user}

  shared_context 'authenticated' do
    before :each do
      allow(controller).to receive(:current_user).and_return(current_nplol_user)
    end
  end

  describe 'authentication' do
    let(:post_model) { create :post }
    let(:post_params) { { title: nil }}

    it 'doesn\'t allow access to *new*' do
      get :new
      expect(flash[:error]).to_not be_nil
      expect(response).to redirect_to(root_url)
    end

    it 'doesn\'t allow access to *create*' do
      post :create, post: post_params
      expect(flash[:error]).to_not be_nil
      expect(response).to redirect_to(root_url)
    end

    it 'doesn\'t allow access to *edit*' do
      get :edit, id: post_model.to_param
      expect(flash[:error]).to_not be_nil
      expect(response).to redirect_to(root_url)
    end

    it 'doesn\'t allow access to *update*' do
      put :update, { id: post_model.to_param, post: post_params }
      expect(flash[:error]).to_not be_nil
      expect(response).to redirect_to(root_url)
    end

    it 'doesn\'t allow access to *destroy*' do
      delete :destroy, id: post_model.to_param
      expect(flash[:error]).to_not be_nil
      expect(response).to redirect_to(root_url)
    end

  end

  before :each do
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe 'index' do
    before :each do
      5.times { create :public_post }
      4.times { create :private_post }
    end

    it 'finds only public posts' do
      get :index

      expect(assigns(:posts)).to_not be_nil
      expect(assigns(:posts).length).to eq(5)
    end

    describe 'private posts' do
      include_context 'authenticated'

      it 'finds all posts for nplol-members' do
        get :index

        expect(assigns(:posts)).to_not be_nil
        expect(assigns(:posts).length).to eq(9)
      end
    end

    context 'calculating post scores' do
      let(:user1) { create :user }
      let(:user2) { create :user }
      let(:post) { create :post }

      before :each do
        3.times { create :post }
      end

      it 'calculates average score as 0 when no comments or likes' do
        get :index
        expect(assigns(:posts).select { |post| post.popular? }.length).to eq(0)
      end

      it 'correctly calculates average score for comments' do
        create :comment, user: user1, post: post
        get :index
        expect(assigns(:posts).select { |post| post.popular? }.length).to eq(1)
      end

    end

  end # index

  describe 'create' do
    include_context 'authenticated'
    let(:valid_post) { attributes_for :post }
    let(:invalid_post) { { title: nil, image: nil } }

    it 'assigns a newly created post as @post for invalid posts' do
      post :create, post: invalid_post
      expect(assigns(:post)).to be_a_new(Post)
    end

    it 'assigns errors to the correct fields' do
      post :create, post: invalid_post
      expect(assigns(:post).errors.messages.length).to eq(2)
      expect(assigns(:post).errors.messages[:image]).to_not be_nil
      expect(assigns(:post).errors.messages[:title]).to_not be_nil
    end

    it 'creates a new Post when attributes are valid' do
      valid_post.merge!( { image: upload_file('valid_image.png', 'image/png') })
      expect { post :create, post: valid_post }.to change(Post, :count).by(1)
    end
  end

  describe 'update posts' do
    include_context 'authenticated'
    let(:post) { create :post }
    let(:valid_attributes) { { title: 'Yarr' } }
    let(:invalid_attributes) { { title: nil } }

    it 'doesn\'t update a post with invalid attributes' do
      put :update, { id: post.to_param, post: invalid_attributes }
      expect(assigns(:post).errors.messages.length).to eq(1)
      expect(response).to render_template('edit')
    end

    it 'updates the post with valid attributes' do
      put :update, { id: post.to_param, post: valid_attributes }
      expect(flash[:notice]).to_not be_nil
      expect(response).to redirect_to(post)
    end
  end

end
