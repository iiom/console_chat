require_relative 'message'
require_relative 'privatemessage'
require_relative 'database'
require_relative 'user'

class Interface
  attr_reader :db, :user

  def initialize(current_path)
    @db_path = current_path + '/Data/DB/console.db'
    @db = DataBase.new(@db_path)
    @user = User.new
  end

  def login
    name = @user.enter_name
    @db.action_with_db("SELECT Name FROM Users WHERE Name = '#{name}'")
  end

  def registr
    name = @user.enter_name
    @db.action_with_db("INSERT INTO Users (Name) VALUES ('#{name}')")
  end

  def logout
    puts "выход"
    exit
  end

  def action(input, name = nil, text = nil, whom = nil)
    if input == 1
      query = Message.write_message(text, name)
    elsif input == 2
      query = Message.read_message
    elsif input == 3
      query = PrivatMessage.write_message(text, name, 'Bob')
    elsif input == 4
      query = PrivatMessage.read_message(name)
    end
  end

  def choice
    puts "Выберите действие:"
    puts "написать общее сообщение - 1\nпрочитать общее сообщение - 2"
    puts "написать личное сообщение - 3\nпрочитать личное сообщенияе - 4"
    puts "выход 0"
    input = STDIN.gets.to_i
  end

  def text_input
    puts "Введите текст сообщения"
    text = STDIN.gets.chomp
  end

  def to_s(db)
    db.each do |i|
      puts
      print i
    end
  end
end
