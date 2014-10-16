require 'rails_helper'

describe PostsController do
  
  before :each do
    user = double('user')
    allow(user).to receive(:nplol?).and_return(false)
    allow(controller).to receive(:current_user).and_return(user)
  end

  shared_context 'authenticated' do
    before :example do
      nplol_user = build :user, :nplol
      allow(controller).to receive(:current_user).and_return(nplol_user)
    end
  end

  describe 'authentication' do
    let(:post) { create :post }

    it 'doesn\'t allow access to protected routes through manage? before_filter' do
      get :new
      expect(flash[:error]).to_not be_nil
      expect(response).to redirect_to(root_url)
    end
    
    context 'nplol users' do
      include_context 'authenticated'
      
      it 'allows access to create new posts' do
        get :new
        expect(response.status).to eq(200)
      end

      it 'allows access to delete posts' do
        delete :destroy, id: post.to_param
        expect(Post.all.length).to eq(0)
        expect(response).to redirect_to(root_url)
      end 
    end

  end

  describe 'public vs private' do
    before :each do
      create_list :post, 5, :public
      create_list :post, 3, :private
    end
    
    context 'regular users' do
      
      it 'finds only public posts' do
        get :index
        expect(assigns(:posts).length).to eq(5)
      end
      
      it 'does not show private posts' do
        get :show, id: Post._private.first.to_param
        expect(response).to redirect_to(root_url)
      end
    end

    context 'nplol users' do
      include_context 'authenticated'
   
      it 'finds all posts' do
        get :index
        expect(assigns(:posts).length).to eq(8)
      end

      it 'shows private posts' do
        get :show, id: Post._private.first.to_param
        expect(response.status).to eq(200)
      end
    end

  end


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
