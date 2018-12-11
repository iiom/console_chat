require_relative 'lib/database'
require_relative 'lib/user'

current_path = File.dirname(__FILE__)
db_path = current_path + '/Data/DB/console.db'


db = DataBase.new(db_path)
user = User.new

puts "выберите рега или логин?\nрегист - 1\nлогин - 2\nвыход - 0"
choice = STDIN.gets.to_i

abort "выход" if choice == 0

puts "имя"
user.enter_name

if choice == 0
  puts "выход"
  db.close
  exit
elsif choice == 1
  db.write_name_to_db(user.name)
  puts 'Регистрация успешна'
else
  result = db.read_name_from_db(user.name)
  puts result.join("\s") == user.name ? 'Авторизация успешна' : 'Такого имени нет в базе'
end


