require 'date'

class Message

  def initialize
    @time_now = Time.now.strftime('%d.%m.%Y')
  end

  def self.write_message(text, name)
    new
    query = "INSERT INTO Messages "
    query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
        " '#{@time_now}', '#{text}', 'общее')"
    query
  end

  def self.read_message
    query = "SELECT * FROM Messages "
    query += "WHERE Whom = 'общее'"
    new
    query
  end
end
