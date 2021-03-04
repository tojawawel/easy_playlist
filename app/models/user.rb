# frozen_string_literal: true

class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[spotify]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.token = EncryptionService.new.encrypt(auth.credentials.token)
      user.refresh_token = EncryptionService.new.encrypt(auth.credentials.refresh_token)
      user.password = Devise.friendly_token[0, 20]
    end
  end

end
