require 'date'

require_relative 'lib/database'
require_relative 'lib/user'

current_path = File.dirname(__FILE__)
p db_path = current_path + '/Data/DB/console.db'

db = DataBase.new(db_path)
user = User.new

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

abort "выход" if choice == 0

puts "имя"
user.enter_name

if choice == 1
  registr(db, user.name)
  puts 'Регистрация успешна'
else
  puts login(db, user.name).join("\s") == user.name ? 'Авторизация успешна' : 'Такого имени нет в базе'
end

puts "Выберите действие:"
puts "написать - 1\nпрочитать - 2"
input1 = STDIN.gets.to_i
query = "INSERT INTO Messages " if input1 == 1
query = "SELECT * FROM Messages " if input1 == 2

puts "общее сообщение - 3\nличные сообщения - 4"
input2 = STDIN.gets.to_i
query += "WHERE Whom = 'общее'" if input2 == 3 && input1 == 2
query += "WHERE Whom = '#{user.name}'" if input2 == 4 && input1 == 2

puts "Введите текст сообщения" if input1 == 1
text = STDIN.gets.chomp if input1 == 1

query += "(Name, Time, Text, Whom) VALUES ('#{user.name}', '#{Time.now.strftime('%d.%m.%Y')}', '#{text}', 'общее')" if input2 == 3 && input1 == 1
query += "(Name, Time, Text, Whom) VALUES ('#{user.name}', '#{Time.now.strftime('%d.%m.%Y')}', '#{text}', 'Bob')" if input2 == 4 && input1 == 1

db.action_with_db(query).each do |i|
  puts
  print i
end

# (Name) VALUES ('#{name}')

# def write_name_to_db(name)
#     @db.execute('INSERT INTO Users (Name) VALUES (?)', name)
#   end
#
#   def read_name_from_db(name)
#     @db.execute('SELECT Name FROM Users WHERE Name = ?', name)
#   end
#
# if choice == 0
#   puts "выход"
#   db.close
#   exit
# elsif choice == 1
#   db.write_name_to_db(user.name)
#   puts 'Регистрация успешна'
# else
#   result = db.read_name_from_db(user.name)
#   puts result.join("\s") == user.name ? 'Авторизация успешна' : 'Такого имени нет в базе'
# end
#


