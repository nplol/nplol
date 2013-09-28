require 'spec_helper'

include AuthHelper

describe PostsController do

  describe "#index" do
    it "gets the index path" do
      get :index
      response.status.should be(200)
    end

    it "assigns the @posts instance variable" do
      get :index
      assigns(:posts).should_not be_nil
    end
  end

  describe "#new" do
    it "gets the new post path" do
      http_login
      get :new
      response.status.should be(200)
    end

    it "assigns a new empty @post resource" do
      http_login
      get :new
      assigns(:post).should_not be_nil
    end
  end

  describe "#create" do
    before {http_login}

    context "saving a valid post" do

      it "creates a new post" do
        expect{ post :create, post: attributes_for(:post) }.to change(Post, :count).by(1) 
      end
      
      it "redirects to post show page upon save" do  
        post :create, post: attributes_for(:post)
        response.should redirect_to Post.last    
      end

    end

    context "saving an invalid post" do

      it "does not create a new post" do
        expect{ post :create, post: attributes_for(:invalid_post) }.to_not change(Post, :count).by(1) 
      end
      
      it "renders the new view upon save" do
        post :create, post: attributes_for(:invalid_post)
        response.should render_template :new
      end

    end

  end

end
    