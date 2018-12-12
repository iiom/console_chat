require_relative 'message'

class PrivatMessage < Message

  def initialize
    super
  end

  def self.write_message(text, name, whom)
    new
    query = "INSERT INTO Messages "
    query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
        " '#{@time_now}', '#{text}', '#{whom}')"
    query
  end

  def self.read_message(name)
    query = "SELECT * FROM Messages "
    query += "WHERE Whom = '#{name}'"
    new
    query
  end
end
