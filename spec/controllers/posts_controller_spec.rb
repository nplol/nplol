require 'spec_helper'

include AuthHelper

describe PostsController do

  describe '#index' do

    before :all do
      5.times do
        create :post
      end
    end

    it 'assigns the @posts instance variable' do
      get :index

      expect(assigns(:posts)).to_not be_nil
      expect(assigns(:posts).length).to eq(5)
    end
  end

  describe '#new' do

    before :each do
      http_login
    end

    context 'post' do

      it 'assigns a local post variable' do
        get :new
        expect(assigns(:post)).to_not be_nil
        expect(assigns(:post).type).to be_nil
      end

    end

    context 'meme' do

      it 'assigns a local post variable of type meme' do
        get :new
        xhr :post, 'form', post: {type: 'meme'}

        expect(assigns(:post)).to_not be_nil
        expect(assigns(:post).type).to eq('Meme')
      end

    end

  end

  describe '#create' do

    before :each do
      http_login
    end

    context 'saving a valid post' do

      it 'creates a new post' do
        expect{ post :create, post: attributes_for(:post) }.to change(Post, :count).by(1) 
      end
      
      it 'redirects to post show page upon save' do
        post :create, post: attributes_for(:post)

        expect(response).to redirect_to Post.last
      end

    end

    context 'saving an invalid post' do

      it 'does not create a new post' do
        expect{ post :create, post: attributes_for(:invalid_post) }.to_not change(Post, :count).by(1) 
      end
      
      it 'renders the new view upon false save' do
        post :create, post: attributes_for(:invalid_post)

        expect(response).to render_template :new
        expect(assigns(:post)).to_not be_nil
      end

      it 'generates error messages' do
        post :create, post: attributes_for(:invalid_post)

        expect(assigns(:post)).to have(2).errors_on(:title)
        expect(assigns(:post)).to have(1).errors_on(:content)
      end

    end

  end

  describe '#edit' do
    let(:resource) { create :post }
    
    before :each do
      http_login      
    end

    it 'renders the form for a specific post' do
      get :edit, id: resource.id

      expect(assigns(:post)).to_not be_nil
      expect(assigns(:post)).to eq(resource)
    end

    context 'updating a post with valid values' do

      it 'updates the post\'s attributes' do

        put :update, id: resource.id, post: attributes_for(:post, title: 'NewTitle', content: 'NewContent')

        # reload fetches updated attributes for the given object from the database
        resource.reload

        expect(resource.title).to eq('NewTitle')
        expect(resource.content).to eq('NewContent')
      end

      it 'redirects to the show view for the given post' do
        put :update, id: resource.id, post: attributes_for(:post, title: 'NewTitle', content: 'NewContent')

        expect(response).to redirect_to resource
        expect(assigns(:post)).to_not be_nil
        expect(assigns(:post)).to eq(resource)
      end

    end

    context 'updating a post with invalid values' do

      it 'does not update the post\'s attributes' do
        put :update, id: resource, post: attributes_for(:invalid_post)
        resource.reload

        expect(resource.title).to include('Hunting dat whale')
        expect(resource.content).to eq('Ahab\'s mission was null and void.')
      end

      it 'generates error messages' do
        put :update, id: resource, post: attributes_for(:invalid_post)

        expect(assigns(:post)).to have(2).errors_on(:title)
        expect(assigns(:post)).to have(1).errors_on(:content)
      end

    end

  end

  describe '#destroy' do

    before :each do
      http_login
    end

    let(:resource) { create :post }

    it 'deletes the post' do
      expect(resource.title).to include('Hunting dat whale')
      expect{ delete :destroy, id: resource.id }.to change(Post, :count).by(-1)
    end

    it 'redirects to posts path' do
      delete :destroy, id: resource.id
      expect(response).to redirect_to posts_path
    end


  end

end
    