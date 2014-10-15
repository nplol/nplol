require 'rack/test'

module ControllerHelper

  def upload_file(name, content_type)
    Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/#{name}", content_type)
  end

  def format_tags(tags)
    tags.join(', ')
  end

  def http_login
    user = '2pac'
    password = '2pac'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,password)
  end 

end
