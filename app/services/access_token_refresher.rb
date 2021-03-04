# frozen_string_literal: true

class AccessTokenRefresher

  URL = 'https://accounts.spotify.com/api/token'

  def initialize(user)
    @user = user
  end

  def call
    new_encrypted_access_token = encrypt_access_token
    user.update(token: new_encrypted_access_token)
  end

  private

  attr_reader :user

  def new_access_token
    response = HTTParty.post(URL, params)
    response['access_token']
  end

  def encrypt_access_token
    EncryptionService.new.encrypt(new_access_token)
  end

  def params
    {
      headers: { authorization: "Basic #{auth_64}", 'content-type': 'application/x-www-form-urlencoded' },
      body: { grant_type: 'refresh_token', refresh_token: get_refresh_token }
    }
  end

  def get_refresh_token
    EncryptionService.new.decrypt(user.refresh_token)
  end

  def auth_64
    Rails.application.credentials.spotify[:basic_auth_64]
  end

end
