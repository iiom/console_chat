require 'date'

class Message
  TIME_NOW = Time.now.strftime('%d.%m.%Y')

  def self.write_message(text, name)
    query = "INSERT INTO Messages "
    query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
        " '#{TIME_NOW}', '#{text}', 'общее')"
    new
    query
  end

  def self.read_message
    query = "SELECT * FROM Messages "
    query += "WHERE Whom = 'общее'"
    new
    query
  end

  def self.to_s(db)
    db.each do |i|
      puts
      print i
    end
  end
end
