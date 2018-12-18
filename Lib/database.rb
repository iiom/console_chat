require 'sqlite3'

class DataBase

  def initialize(db_path)
    @db = SQLite3::Database.open(db_path)
  end

  def action_with_db(param)
    @db.execute(param)
  end

  def db_to_hash
    @db.results_as_hash = true
  end
end
