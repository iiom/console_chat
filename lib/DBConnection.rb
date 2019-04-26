require 'sqlite3'

class DBConnection
  def self.db_configuration(yml, env)
    ActiveRecord::Base.establish_connection(YAML.load(File.read(yml))[env])
  end
end
