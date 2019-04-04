require 'active_record'
require_relative 'lib/models/user'
require_relative 'lib/models/message'
require_relative 'lib/DBConnection'


db_configuration_file = File.join(File.expand_path('..', __FILE__), 'db', 'config.yml')
DBConnection.db_configuration(db_configuration_file)

def sign_login
  choice = nil
  until choice == 1 || choice == 2
    puts "Выберите регистрация или авторизация\nregistr - 1\nlogin - 2"
    choice = STDIN.gets.chomp.to_i
    if choice == 1
      puts 'Введите ваше Имя(login name)'
      name = STDIN.gets.chomp
      puts 'email'
      email = STDIN.gets.chomp
      user = User.new(name: name, email: email)
      user.save
      if user.errors.present?
        choice = nil
        user.errors.each {|i| p i}
      else
        puts "Регистрация #{user.name} завершена\n\n"
      end
    elsif choice == 2
      puts 'Введите email'
      email = STDIN.gets.chomp
      user = User.find_by(email: email)
      if user.nil?
        choice = nil
        puts 'Такого имени нет в базе'
      else
        puts "Авторизация #{user.name} успешна\n\n"
      end
    end
  end
end

def read_right_message
  choice = nil
  puts '1 - написать сообщение'
  puts '2 - прочитать сообщения адресованные пользователю'
  puts '3 - прочитать написанное пользователем'
  puts '9 - выход'
  choice = STDIN.gets.chomp

  if choice == 9
    puts 'bye bye'
  elsif choice.to_i == 1
    puts 'enter message'
    text = STDIN.gets.chomp
    puts 'whom? if no one is left blank'
    whom = STDIN.gets.chomp
    whom = nil if whom == ''
    Message.create(text: text, user: user, whom: whom)
  elsif choice.to_i == 2
    Message.where(whom: user.name).each {|i| puts i.text}
    read_right_message
  elsif choice.to_i == 3
    Message.where(user_id: user.id).each {|i| puts i.text}
    read_right_message
  else
    puts "wrong input - #{choice}"
    read_right_message
  end
end

sign_login
read_right_message
