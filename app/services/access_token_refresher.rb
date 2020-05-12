# frozen_string_literal: true
class AccessTokenRefresher
  URL = "https://accounts.spotify.com/api/token"

  def call(user)
    token = new_access_token(user)
    new_encrypted_access_token = EncryptionService.encrypt(token)
    user.update(token: new_encrypted_access_token)
  end

  def new_access_token(user)
    response = HTTParty.post(URL, params(user))
    response['access_token']
  end

  private

  def params(user)
      {
        headers: {authorization: "Basic #{auth_64}" , 'content-type': "application/x-www-form-urlencoded" }, 
        body: {grant_type: 'refresh_token', refresh_token: get_refresh_token(user)}
      }
  end

  def get_refresh_token(user)
    EncryptionService.decrypt(user.refresh_token)
  end

  def auth_64
    Rails.application.credentials.spotify[:basic_auth_64]
  end
end
