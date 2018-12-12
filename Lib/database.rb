require 'sqlite3'

class DataBase

  def initialize(db_path)
    @db = SQLite3::Database.open(db_path)
  end

  def action_with_db(param)
    @db.execute(param)
  end

  # def write_name_to_db(name)
  #   @db.execute('INSERT INTO Users (Name) VALUES (?)', name)
  # end
  #
  # def read_name_from_db(name)
  #   @db.execute('SELECT Name FROM Users WHERE Name = ?', name)
  # end
end
