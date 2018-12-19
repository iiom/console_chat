require_relative 'lib/database'
require_relative 'lib/user'
require_relative 'lib/interface'

current_path = File.dirname(__FILE__)
interface = Interface.new(current_path)

loop do
  choice = nil
  until choice == 1 || choice == 2
    puts "выберите рега или логин?\nregistr - 1\nlogin - 2"
    choice = STDIN.gets.chomp.to_i
    if choice == 1
      name = ""
      until name.size >= 3
        puts "имя"
        name = STDIN.gets.chomp
        puts "Имя должно быть не короче трёх символов" if name.size < 3
      end
      user = User.new(name)
      interface.registr(name)
      puts 'Регистрация завершена'
    elsif choice == 2
      name = nil
      while interface.login?(name) == false
        puts "Введите имя"
        name = STDIN.gets.chomp
        user = User.new(name)
        puts 'Такого имени нет в базе' if interface.login?(name) == false
      end
      puts "Авторизация успешна\n\n\n"
    else
      puts "wrong input"
    end
  end

  choice = nil
  while choice != 9
    puts "\n\nВыберите действие:"
    puts "написать общее сообщение - 1\nпрочитать общее сообщение - 2"
    puts "написать личное сообщение - 3\nпрочитать личное сообщенияе - 4"
    puts "выход - 9"

    choice = STDIN.gets.chomp.to_i
    if choice == 1 || choice == 3
      puts "Введите текст сообщения"
      text = STDIN.gets.chomp
      if choice == 3
        puts "Кому хотите отправить сообщение"
        whom = STDIN.gets.chomp
      end
    end
    query = interface.make_query_request2(choice, user.name, text, whom)

    interface.load_message(query) if [1, 2, 3, 4].include?(choice)
    interface.messages.each {|i| i.to_s} if [2, 4].include?(choice)
  end
end
