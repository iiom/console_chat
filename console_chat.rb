require 'date'

require_relative 'lib/database'
require_relative 'lib/user'
require_relative 'lib/interface'

current_path = File.dirname(__FILE__)
db_path = current_path + '/Data/DB/console.db'

db = DataBase.new(db_path)
user = User.new
interface = Interface.new

def login(db, name)
  db.action_with_db("SELECT Name FROM Users WHERE Name = '#{name}'")
end

def registr(db, name)
  db.action_with_db("INSERT INTO Users (Name) VALUES ('#{name}')")
end

def logout
  puts "выход"
  db.close
  exit
end

puts "выберите рега или логин?\nregistr - 1\nlogin - 2"
choice = STDIN.gets.to_i

puts "имя"
name = user.enter_name

if choice == 1
  registr(db, user.name)
  puts 'Регистрация успешна'
else
  puts login(db, user.name).join("\s") == user.name ? 'Авторизация успешна' : 'Такого имени нет в базе'
end

choice = interface.choice
text = interface.text_input if choice == 1 || choice == 3
query = interface.action(choice, name, text, 'Bob')

interface.to_s(db.action_with_db(query)) if choice == 2 || choice == 4
