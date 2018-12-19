require 'sqlite3'

class DataBase

  def initialize(db_path)
    @db = SQLite3::Database.open(db_path)
  end

  def action_with_db(param1, param2)
    @db.results_as_hash = param2
    @db.execute(param1)
  end
end
