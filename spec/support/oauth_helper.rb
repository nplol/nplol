module OauthHelper

  def build_hash(options)
    {
      provider: options[:provider],
      uid: options[:uid],
      info: {
        name:   'Jon Snow',
        email:  options[:email],
        first_name: 'Jon',
        last_name: 'Snow',
        image: 'https://url.jpg'
      }
    }
  end

end
