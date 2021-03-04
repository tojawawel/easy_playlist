# frozen_string_literal: true

class EncryptionService

  SALT = Rails.application.credentials.salt
  KEY = ActiveSupport::KeyGenerator.new('password').generate_key(SALT, 32).freeze

  private_constant :KEY

  def encrypt(value)
    encryptor.encrypt_and_sign(value)
  end

  def decrypt(value)
    encryptor.decrypt_and_verify(value)
  end

  private

  def encryptor
    ActiveSupport::MessageEncryptor.new(KEY)
  end

end
