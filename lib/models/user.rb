class User < ActiveRecord::Base
  has_many :messages

  validates :name, :email, presence: true, uniqueness: true
  validates :name, format: {with: /\A[\w]+\z/, message: 'only allows letters numbers & _'}
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'email format only'}
end