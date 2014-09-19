require 'rack/test'

module ControllerHelper

  def upload_file(name, content_type)
    Rack::Test::UploadedFile.new("#{Rails.root}/spec/files/#{name}", content_type)
  end

  def format_tags(tags)
    tags.join(', ')
  end

end
