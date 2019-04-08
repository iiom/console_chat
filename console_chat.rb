require 'active_record'
require_relative 'lib/models/user'
require_relative 'lib/models/message'
require_relative 'lib/DBConnection'


db_configuration_file = File.join(File.expand_path('..', __FILE__), 'db', 'config.yml')
DBConnection.db_configuration(db_configuration_file)

def sign_in
  puts 'Введите ваше Имя(login name)'
  name = STDIN.gets.chomp
  puts 'Введите ваш (email)'
  email = STDIN.gets.chomp
  puts 'Введите пароль'
  password = STDIN.gets.chomp

  begin
    user = User.create!(name: name, email: email, password: password)
  rescue ActiveRecord::RecordInvalid => errors
    puts '______________________________________________'
    puts errors
    puts '______________________________________________'
    return action_sign_login_in_console
  end

  if user.present?
    puts "Регистрация #{user.name} завершена\n\n"
    action_with_message_in_console(user)
  end
end

def log_in
  puts 'Введите email'
  email = STDIN.gets.chomp
  puts 'Введите password'
  password = STDIN.gets.chomp
  user = User.authenticate(email, password)

  if user.present?
    puts "Авторизация #{user.name} успешна\n\n"
    action_with_message_in_console(user)
  else
    puts '______________________________________________'
    puts 'Не верный email или password'
    puts '______________________________________________'
    return action_sign_login_in_console
  end
end


def text_in_console(user)
  return nil if user.nil?
  puts
  puts '______________________________________________'
  puts "всего личных сообщений - #{Message.where(whom: user.name).count}"
  puts "не прочитанных личных сообщений - #{Message.where(whom: user.name, view: false).count}"
  puts '______________________________________________'
  puts
  puts '1 - написать сообщение'
  puts '2 - прочитать новые сообщения адресованные пользователю'
  puts '3 - прочитать написанное пользователем'
  puts '9 - выход'
  puts
end

def write_message(user)
  puts 'enter message'
  text = STDIN.gets.chomp
  puts 'whom(name user)? if no one is left blank'
  whom = STDIN.gets.chomp
  whom = nil if whom == ''
  if whom.nil?
    Message.create!(text: text, user: user, whom: whom)
    puts 'сообщение отправлено'
  else
    if User.find_by(name: whom).nil?
      puts "нет такого пользователя #{whom}"
    else
      Message.create!(text: text, user: user, whom: whom)
      puts "сообщение отправлено пользователю: #{whom}"
    end
  end
end

def read_new_message_addressed_to_user(user)
  m = Message.where(whom: user.name, view: false)
  puts '______________________________________________'
  if m.empty?
    puts 'У вас нет новых сообщений'
  else
    puts "сообшения не прочитанные пользователем:"
  end
  m.each do |i|
    puts
    print "from: #{i.user.name}"
    i.whom.nil? ? puts : (puts " to: #{i.whom}")
    puts "text: #{i.text}"
    puts i.created_at
    m.update(view: true)
  end
end

def read_message_written_by_user(user)
  m = Message.where(user_id: user.id)
  puts '______________________________________________'
  if m.empty?
    puts 'У вас нет сообщений'
  else
    puts "все сообшения написанные пользователем:"
  end
  m.each do |i|
    puts
    print "from: #{i.user.name}"
    i.whom.nil? ? puts : (puts " to: #{i.whom}")
    puts "text: #{i.text}"
    puts i.created_at
  end
end

def action_sign_login_in_console
  puts "\nВыберите регистрация или авторизация\nregistr - 1\nlogin - 2\nexit - 9"
  choice = STDIN.gets.chomp

  if choice.to_i == 9
    return puts 'bye bye'
  elsif choice.to_i == 1
    user = sign_in
  elsif choice.to_i == 2
    user = log_in
  else
    puts '______________________________________________'
    puts "wrong input - #{choice}"
    puts '______________________________________________'
    action_sign_login_in_console
  end
end


def action_with_message_in_console(user)
  choice = nil
  while choice.to_i != 9
    text_in_console(user)
    choice = STDIN.gets.chomp

    if choice.to_i == 9
      return puts 'bye bye'
    elsif choice.to_i == 1
      write_message(user)
    elsif choice.to_i == 2
      read_new_message_addressed_to_user(user)
    elsif choice.to_i == 3
      read_message_written_by_user(user)
    else
      puts '______________________________________________'
      puts "wrong input - #{choice}"
      puts '______________________________________________'
    end
  end
end

action_sign_login_in_console

# user = User.authenticate('qq@qq.ru', 'qq')
# m = Message.where(whom: user.name, view: false)
# m.each do |i|
#   puts i.text
#   m.update(view: true)
# end
# # Message.where(whom: user.name).update(view: false)

# Message.where(whom: user.name).each {|i| puts i.view}