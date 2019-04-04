require 'active_record'
require_relative 'lib/models/user'
require_relative 'lib/models/message'
require_relative 'lib/DBConnection'


db_configuration_file = File.join(File.expand_path('..', __FILE__), 'db', 'config.yml')
DBConnection.db_configuration(db_configuration_file)

def sign_login
  choice = nil
  puts "Выберите регистрация или авторизация\nregistr - 1\nlogin - 2\nexit - 9"
  choice = STDIN.gets.chomp

  if choice.to_i == 9
    puts 'bye bye'
  elsif choice.to_i == 1
    puts 'Введите ваше Имя(login name)'
    name = STDIN.gets.chomp
    puts 'Введите ваш (email)'
    email = STDIN.gets.chomp
    user = User.create(name: name, email: email)
    if user.errors.present?
      p user.errors.each {|i| i}
      sign_login
    else
      puts "Регистрация #{user.name} завершена\n\n"
    end
  elsif choice.to_i == 2
    puts 'Введите email'
    email = STDIN.gets.chomp
    user = User.find_by(email: email)
    if user.nil?
      puts 'Такого имени нет в базе'
      sign_login
    else
      puts "Авторизация #{user.name} успешна\n\n"
    end
  else
    puts "wrong input - #{choice}"
    sign_login
  end
  read_wright_message(user)
end

def read_wright_message(user)
  choice = nil
  puts '1 - написать сообщение'
  puts '2 - прочитать сообщения адресованные пользователю'
  puts '3 - прочитать написанное пользователем'
  puts '9 - выход'
  choice = STDIN.gets.chomp

  if choice.to_i == 9
    puts 'bye bye'
  elsif choice.to_i == 1
    puts 'enter message'
    text = STDIN.gets.chomp
    puts 'whom? if no one is left blank'
    whom = STDIN.gets.chomp
    whom = nil if whom == ''
    Message.create(text: text, user: user, whom: whom)
    read_wright_message(user)
  elsif choice.to_i == 2
    Message.where(whom: user.name).each {|i| puts i.text}
    read_wight_message(user)
  elsif choice.to_i == 3
    Message.where(user_id: user.id).each {|i| puts i.text}
    read_wright_message(user)
  else
    puts "wrong input - #{choice}"
    read_wright_message(user)
  end
end

sign_login

