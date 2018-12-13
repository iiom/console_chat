require_relative 'message'
require 'date'

class PrivatMessage < Message

  def self.write_message(text, name, whom)
    new
    query = "INSERT INTO Messages "
    query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
        " '#{TIME_NOW}', '#{text}', '#{whom}')"
    query
  end

  def self.read_message(name)
    query = "SELECT * FROM Messages "
    query += "WHERE Whom = '#{name}'"
    new
    query
  end
end
