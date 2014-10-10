require 'rails_helper'

describe PostsController do
  
  # TODO: necessary?
  after :all do
    Post.destroy_all
    Tag.destroy_all
  end

  before :example do
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
    let(:post_id) { 1337  }
    let(:post_params) { { title: nil }}

    it 'doesn\'t allow access to protected routes through manage? before_filter' do
      get :new
      expect(flash[:error]).to_not be_nil
      expect(response).to redirect_to(root_url)
    end

  end

  describe 'index' do
    before :all do
      create_list :post, 5, :public
      create_list :post, 3, :private
    end
    
    context 'regular users' do
      it 'finds only public posts' do
        get :index
        expect(assigns(:posts).length).to eq(5)
      end
    end

    context 'nplol users' do
      include_context 'authenticated'
      it 'finds all posts' do
        get :index
        expect(assigns(:posts).length).to eq(8)
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

  describe 'tags' do
    include_context 'authenticated'
    let(:post) { create :post }
    let(:tags) { [ Tag.find(1).name, Tag.find(2).name, Tag.find(3).name ] }
    before :all do
      5.times { create :tag }
    end

    after :each do
      post.tags.destroy_all
      if tags.length != 3 # i.e. tags has been modified
        tags = [ Tag.find(1).name, Tag.find(2).name, Tag.find(3).name]
      end
    end

    it 'adds existing tags to a post' do
      put :update, id: post.to_param, post: { tag_list: tags.join(', ') }
      expect(assigns(:post).tags.length).to eq(3)
    end

    it 'doesn\'t create more tags than necessary' do
      tags << 'tag99'
      put :update, id: post.to_param, post: { tag_list: tags.join(', ') }
      expect(Tag.all.length).to eq(6)
    end

    it 'only adds properly formatted tags' do
      put :update, id: post.to_param, post: { tag_list: "tag101, tag102    tag103\ntag104,tag105" }
      expect(post.tags.length).to eq(3)
      expect(Tag.all.length).to eq(8)
    end

    it 'deletes tags from a post' do
      tags.pop
      put :update, id: post.to_param, post: { tag_list: tags.join(', ') }
      expect(assigns(:post).tags.length).to eq(2)
    end

  end

end
