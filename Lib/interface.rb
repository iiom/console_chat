require_relative 'message'
require_relative 'privatemessage'
require_relative 'database'

class Interface
  attr_reader :db

  def initialize(current_path)
    @db_path = current_path + '/Data/DB/console.db'
    @db = DataBase.new(@db_path)
  end

  def make_query_request(input, name = nil, text = nil, whom = nil)
    if input == 1
      query = Message.write_message(text, name)
    elsif input == 2
      query = Message.read_message
    elsif input == 3
      query = PrivatMessage.write_message(text, name, whom)
    elsif input == 4
      query = PrivatMessage.read_message(name)
    end
  end

  def input
    STDIN.gets.chomp
  end

  def to_s(db)
    db.each do |i|
      puts
      print i
    end
  end

  def login?(name)
    result = @db.action_with_db("SELECT Name FROM Users WHERE Name = '#{name}'")
    result.join("\s") == name
  end

  def registr(name)
    @db.action_with_db("INSERT INTO Users (Name) VALUES ('#{name}')")
  end
end
