require 'sqlite3'

class DBConnection
  def self.db_configuration(yml)
    ActiveRecord::Base.establish_connection(YAML.load(File.read(yml))["development"])
    end
end
