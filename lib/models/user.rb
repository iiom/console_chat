require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

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
      self.password_hash = BCrypt::Password.create(password)
    end
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    return nil unless user.present?
    return user if BCrypt::Password.new(user.password_hash) == password
    nil
  end

  def name_downcase!
    self.name.downcase!
  end
end