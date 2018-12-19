require 'date'
require_relative 'message'
require_relative 'database'

class Interface

  def initialize(current_path)
    @db_path = current_path + '/Data/DB/console.db'
    @db = DataBase.new(@db_path)
  end

  def load_message(query)
    messages = []
    @db.action_with_db(query, true).each do |str|
      messages << Message.new(str)
    end
    messages
  end

  def make_query_request2(input, name = nil, text = nil, whom = nil)
    if input == 1
      query = "INSERT INTO Messages "
      query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
          " '#{Time.now.strftime('%d.%m.%Y %H:%M:%S')}', '#{text}', 'общее')"
    elsif input == 2
      query = "SELECT * FROM Messages "
      query += "WHERE Whom = 'общее'"
    elsif input == 3
      query = "INSERT INTO Messages "
      query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
          " '#{Time.now.strftime('%d.%m.%Y %H:%M:%S')}', '#{text}', '#{whom}')"
    elsif input == 4
      query = "SELECT * FROM Messages "
      query += "WHERE Whom = '#{name}'"
    end
    query
  end

  def login?(name)
    result = @db.action_with_db("SELECT Name FROM Users WHERE Name = '#{name}'", false)
    result.join("\s") == name
  end

  def registr(name)
    @db.action_with_db("INSERT INTO Users (Name) VALUES ('#{name}')", false)
  end
end
