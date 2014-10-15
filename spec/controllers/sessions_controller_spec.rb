require 'rails_helper'

describe SessionsController do
  include OauthHelper
  

  describe 'logging in' do

    let(:google_hash) { 
      build_hash( { email: 'jon@snow.org', 
                    uid: '123', 
                    provider: 'google' })
    }
    let(:mock_hash) {
      build_hash( { email: 'jon@snow.org',
                    uid: '999',
                    provider: 'foogle' })
    }
    let(:mock_hash2) {
      build_hash( { email: 'robb@stark.org',
                    uid: '999',
                    provider: 'foogle' })
    }
    let(:user) { User.find_by(email: 'jon@snow.org') }
   
    before :all do
      create :user_with_identities, email: 'jon@snow.org'
    end  
    
    context 'existing identity' do

      before :example do
        controller.request.env['omniauth.auth'] = google_hash
      end

      it 'logs in the user without creating a new identity' do
        get :create, provider: ''
        expect(Identity.all.length).to eq(2)
      end
      
      it 'logs in the user' do
        get :create, provider: ''
        expect(session[:user_id]).to eq(user.uuid)
      end
    
    end

    context 'new identity, common email' do
      
      before :example do
        controller.request.env['omniauth.auth'] = mock_hash
      end
     
      it 'finds the correct user through email' do
        expect(User).to receive(:find_by_auth).and_return(user)
        get :create, provider: ''
      end

      it 'creates a new identity for the user' do
        get :create, provider: ''
        expect(user.identities.length).to eq(3)
      end
      
      it 'logs in the user' do
        get :create, provider: ''
        expect(session[:user_id]).to eq(user.uuid)
      end

    end 

    context 'new identity, different email' do
   
      before :example do
        controller.request.env['omniauth.auth'] = mock_hash2
      end

     it 'redirects to new_user_url' do
        get :create, provider: ''
        expect(response).to redirect_to(new_user_url(auth: mock_hash2))
     end 
     
    end
  end

  describe 'authorize' do
    # TODO
  end

  describe 'logout' do
    # TODO
  end

end
