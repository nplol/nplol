require 'rails_helper'
require_relative '../support/oauth_helper'

describe SessionsController do
  let(:oauth_hash) { build_oauth_hash(email: 'jon@snow.com')  }

  before :all do
    create :user_with_identities, email: 'jon@snow.com'
  end  

  it 'finds existing users based on oauth_hash' do
     
  end

end
