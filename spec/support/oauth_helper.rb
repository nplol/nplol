module OauthHelper

  def build_hash(options)
    {
      provider: 'mock_provider',
      uid: '12345678',
      info: {
        name:   'Jon Snow',
        email:  options[:email],
        first_name: 'Jon',
        last_name: 'Snow',
        image: 'https://url.jpg'
      },
      credentials: {
        token: 'token',
        refresh_token: 'token2'
      }
    }
  end

end
