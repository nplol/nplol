require 'spec_helper'

# todo: remove controller specs, and move unit tests to
#       models instead.

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
      
      it "renders the new view upon false save" do
        post :create, post: attributes_for(:invalid_post)

        response.should render_template :new
        assigns(:post).should_not be_nil
      end

      it "generates error messages" do
        post :create, post: attributes_for(:invalid_post)

        assigns(:post).should have(1).errors_on(:title)
        assigns(:post).should have(1).errors_on(:content)
      end

    end
  end

  describe "#edit" do 
    let(:resource) { create :post }
    
    before :each do
      http_login      
    end

    context "when resource is found" do

      it "responds with 200" do
        get :edit, id: resource

        response.status.should be(200)
      end

      it "renders the form for a specific post" do
        get :edit, id: resource
              
        assigns(:post).should_not be_nil
        assigns(:post).should eq(resource)
      end

      context "updating a post with valid values" do

        it "updates the post's attributes" do
          put :update, id: resource, post: attributes_for(:post, title: 'NewTitle', content: 'NewContent')
          # reload fetches updated attributes for the given object from the database      
          resource.reload
                
          resource.title.should eq('NewTitle')
          resource.content.should eq('NewContent')
        end

        it "redirects to the show view for the given post" do
          put :update, id: resource, post: attributes_for(:post, title: 'NewTitle', content: 'NewContent')
                
          response.should redirect_to resource
          assigns(:post).should_not be_nil
          assigns(:post).should eq(resource)
        end

      end

      context "updating a post with invalid values" do

        it "does not update the post's attributes" do
          put :update, id: resource, post: attributes_for(:invalid_post)
          resource.reload
        
          resource.title.should eq("Hunting dat whale")
          resource.content.should eq("Ahab's mission was null and void.")
        end 

        it "renders the edit view" do
          put :update, id: resource, post: attributes_for(:invalid_post)

          response.should render_template :edit
          assigns(:post).should_not be_nil
          assigns(:post).should eq(resource)
        end

        it "generates error messages" do
          put :update, id: resource, post: attributes_for(:invalid_post)

          assigns(:post).should have(1).errors_on(:title)
          assigns(:post).should have(1).errors_on(:content)        
        end

      end

    end

    context "when resource is not found" do
      before :each do
        Post.stub(:find_by_id).and_return(nil)
      end

      it "responds with 404" do
        get :edit, id: 'invalid'

        response.response_code.should be(404)
      end

    end

  end

  describe '#destroy' do

    before :each do
      http_login
    end

    context "when resource is not found" do
      before :each do
        Post.stub(:find_by_id).and_return(nil)
      end

      it "responds with 404" do
        delete :destroy, id: 'invalid'

        response.response_code.should be(404)
      end
      #

    end

    let(:resource) { create :post }

    context "when resource is found" do
      
      it "gets the destroy post path" do
        delete :destroy, id: resource
        response.response_code.should be(302)
      end

      it "deletes the post" do
        resource.title.should eq("Hunting dat whale")
        expect{ delete :destroy, id: resource }.to change(Post, :count).by(-1) 
      end

      it "redirects to posts path" do
        delete :destroy, id: resource
        response.should redirect_to posts_path
      end

    end

  end

end
    