module OmniauthMacros
  def mock_auth_google_hash(email = 'myemail@gmail.com')
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(provider: 'google_oauth2',
                                                                  uid: '123456',
                                                                  info: { email: email, name: 'SomeName' })
  end 

  def invalid_credentials
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  end
end