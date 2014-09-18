require 'rack/test'

module ControllerHelper

  def http_login
    user = '2pac'
    pw = '2pac'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  def upload_file(name, content_type)
    Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/#{name}", content_type)
  end

end
