require 'date'

require_relative 'lib/database'
require_relative 'lib/user'
require_relative 'lib/interface'

current_path = File.dirname(__FILE__)

interface = Interface.new(current_path)

puts "выберите рега или логин?\nregistr - 1\nlogin - 2"
choice = STDIN.gets.to_i

if choice == 1
  puts "имя"
  interface.registr
  puts 'Регистрация успешна'
else
  puts "имя"
  puts interface.login.join("\s") == interface.user.name ? 'Авторизация успешна' : 'Такого имени нет в базе'
end

choice = interface.choice
interface.logout if choice == 0
text = interface.text_input if choice == 1 || choice == 3
query = interface.action(choice, name, text, 'Bob')

interface.to_s(db.action_with_db(query)) if choice == 2 || choice == 4
