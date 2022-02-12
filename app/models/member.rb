class Member < ApplicationRecord
  has_secure_password
  has_many :permission
  has_many :log_activity
  before_update :set_access_token_edit
  before_create :set_access_token
  validates :username,  length: { maximum: 50 }, uniqueness: true, format: { :with => /\A[a-z0-9_.]+\Z/i }

  private

  def set_access_token
    self.access_token = encrypt('PGN50lut10n!')
  end

  def set_access_token_edit
    self.access_token = encrypt('PGN50lut10n!')
  end

  def encrypt text
    text = text.to_s unless text.is_a? String

    len = ActiveSupport::MessageEncryptor.key_len
    salt  = SecureRandom.hex len
    # salt = password_digest
    key = ActiveSupport::KeyGenerator.new(Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    encrypted_data = crypt.encrypt_and_sign text
    "#{salt}$$#{encrypted_data}"
  end
end
