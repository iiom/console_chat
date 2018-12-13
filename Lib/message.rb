require 'date'

class Message
TIME_NOW = Time.now.strftime('%d.%m.%Y')

  def self.write_message(text, name)
    new
    query = "INSERT INTO Messages "
    query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
        " '#{TIME_NOW}', '#{text}', 'общее')"
    query
  end

  def self.read_message
    query = "SELECT * FROM Messages "
    query += "WHERE Whom = 'общее'"
    new
    query
  end
end
