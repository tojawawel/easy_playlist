# frozen_string_literal: true

class EncryptionService

  SALT = Rails.application.credentials.salt
  KEY = ActiveSupport::KeyGenerator.new('password').generate_key(SALT, 32).freeze

  private_constant :KEY

  delegate :encrypt_and_sign, :decrypt_and_verify, to: :encryptor

  def self.encrypt(value)
    new.encrypt_and_sign(value)
  end

  def self.decrypt(value)
    new.decrypt_and_verify(value)
  end

  private

  def encryptor
    ActiveSupport::MessageEncryptor.new(KEY)
  end

end
