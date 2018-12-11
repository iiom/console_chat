require 'sqlite3'

class DataBase

  # SQLITE_DB_FILE = '../Data/DB/console.db'

def initialize(db_path)
  @db = SQLite3::Database.open(db_path)
end

  def write_name_to_db(name)
    @db.execute('INSERT INTO Users (Name) VALUES (?)', name)
  end

  def read_name_from_db(name)
    @db.execute('SELECT Name FROM Users WHERE Name = ?', name)
  end
end
