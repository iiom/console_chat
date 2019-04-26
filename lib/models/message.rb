class Message < ActiveRecord::Base
  belongs_to :user
  has_many :messages_users
  has_many :users, through: :messages_users

  validates :text, presence: true
  validates :text, length: {maximum: 255}

  def to_s
    puts
    print "from: #{self.user.name}"
    whom.nil? ? puts : (puts " to: #{whom}")
    puts "text: #{text}"
    puts "#{created_at}"
  end
end