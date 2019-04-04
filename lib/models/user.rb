require 'openssl'

class User < ActiveRecord::Base
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new
  has_many :messages

  before_save :name_downcase!

  validates :name, :email, presence: true, uniqueness: true
  validates :name, format: {with: /\A[\w]+\z/, message: 'only allows letters numbers & _'}
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'email format only'}

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(
              password, password_salt, ITERATIONS, DIGEST.length, DIGEST
          )
      )

    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    hashed_password = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
            password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
    )

    return user if user.password_hash == hashed_password

    nil
  end

  def name_downcase!
    self.name.downcase!
  end
end