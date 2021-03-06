require 'rails_helper'

describe SessionsController do
  include OauthHelper
   
  describe 'logging in' do
    let(:uid) { '123' }
    let(:email) { 'jon@snow.org' }
    let(:google_hash) { 
      build_hash( { email: email,
                    uid: uid, 
                    provider: 'google' })
    }
    let(:user) { User.find_by(email: email) }
    
    before :example do
      create :user, email: email
      create :identity, user: user, uid: uid
    end  
   
    context 'existing identity' do

      before :example do
        controller.request.env['omniauth.auth'] = google_hash
      end

      it 'logs in the user without creating a new identity' do
        get :create, provider: ''
        expect(Identity.all.length).to eq(1)
      end
      
      it 'logs in the user' do
        get :create, provider: ''
        expect(session[:user_id]).to eq(user.uuid)
      end
    
    end

    #context 'new identity, common email' do
      #before :example do
        #controller.request.env['omniauth.auth'] = mock_hash
      #end
     
      #it 'finds the correct user through email' do
        #expect(User).to receive(:find_by_auth).and_return(user)
        #get :create, provider: ''
      #end

      #it 'creates a new identity for the user' do
        #get :create, provider: ''
        #expect(user.identities.length).to eq(3)
      #end
      
      #it 'logs in the user' do
        #get :create, provider: ''
        #expect(session[:user_id]).to eq(user.uuid)
      #end

    #end 

    #context 'new identity, different email' do
      #before :example do
        #controller.request.env['omniauth.auth'] = mock_hash2
      #end

     #it 'redirects to new_user_url' do
        #get :create, provider: ''
        #expect(response).to redirect_to(new_user_url(auth: mock_hash2))
     #end 
     
    #end
  end

  describe 'authorize' do
    let(:user) { User.find_by(email: 'frank@frank.com') }

    before :each do
      user = create :user, email: 'frank@frank.com'
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'gives the current user the *nplol* role if he passes the basic http auth' do
      http_login
      get :authorize_user
      expect(user.role).to eq('nplol')
    end
  
   it 'doesn\'t authorize the user who does not pass the basic http auth' do
      get :authorize_user
      expect(user.role).to eq('regular')
    end

  end

  describe 'logout' do
    before :each do
      session[:dirty] = true
    end

    it 'destroys the current session' do
      get :destroy
      expect(session[:dirty]).to be_nil
    end
  end

end
