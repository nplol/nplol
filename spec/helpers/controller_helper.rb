module ControllerHelper

  def login_nplol
    before :each do
      allow(controller).to receive(:current_user).and_return(current_user)
    end
  end

  def http_login
    user = '2pac'
    pw = '2pac'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

end
