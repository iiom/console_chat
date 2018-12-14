require_relative 'message'

class PrivatMessage < Message

  def self.write_message(text, name, whom)
    query = "INSERT INTO Messages "
    query += "(Name, Time, Text, Whom) VALUES ('#{name}'," +
        " '#{TIME_NOW}', '#{text}', '#{whom}')"
    new
    query
  end

  def self.read_message(name)
    query = "SELECT * FROM Messages "
    query += "WHERE Whom = '#{name}'"
    new
    query
  end

  def self.to_s(db)
    super
  end
end
