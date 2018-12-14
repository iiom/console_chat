require 'date'

require_relative 'lib/database'
require_relative 'lib/user'
require_relative 'lib/interface'

current_path = File.dirname(__FILE__)
interface = Interface.new(current_path)

loop do
  choice = nil
  until choice == 1 || choice == 2
    puts "выберите рега или логин?\nregistr - 1\nlogin - 2"
    choice = interface.input.to_i
    if choice == 1
      puts "имя"
      interface.registr(interface.enter_name)
      puts 'Регистрация завершена'
    elsif choice == 2
      name = nil
      while interface.login?(name) == false
        puts "Введите имя"
        name = interface.enter_name
        puts 'Такого имени нет в базе' if interface.login?(name) == false
      end
      puts "Авторизация успешна\n\n\n"
    else
      puts "wrong input"
    end
  end

  choice = nil
  while choice != 9
    puts "Выберите действие:"
    puts "написать общее сообщение - 1\nпрочитать общее сообщение - 2"
    puts "написать личное сообщение - 3\nпрочитать личное сообщенияе - 4"
    puts "выход - 9"
    choice = interface.input.to_i
    if choice == 1 || choice == 3
      puts "Введите текст сообщения"
      text = interface.input
      if choice == 3
        puts "Кому хотите отправить сообщение"
        whom = interface.input
      end
    end
    query = interface.make_query_request(choice, interface.user.name, text, whom)
    interface.to_s(interface.db.action_with_db(query)) unless ![1, 2, 3, 4].include?(choice)
  end
end



