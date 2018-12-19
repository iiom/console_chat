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
    db_as_hash = true
    @db.action_with_db(query, db_as_hash).each do |str|
      messages << Message.new(str)
    end
    messages
  end

  def make_query_request(input, name = nil, text = nil, whom = nil)
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
    query = "SELECT Name FROM Users WHERE Name = '#{name}'"
    result = @db.action_with_db(query)
    name != "" && result.join("\s") == name
  end

  def query_to_registr(name)
    query = "INSERT INTO Users (Name) VALUES ('#{name}')"
  end
end
