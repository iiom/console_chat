require 'active_record'
require_relative 'lib/models/user'
require_relative 'lib/models/message'
require_relative 'lib/DBConnection'
require_relative 'lib/module/module_session'
require_relative 'lib/module/module_messages'

include Session
include Messages

db_configuration_file = File.join(File.expand_path('..', __FILE__), 'db', 'config.yml')
DBConnection.db_configuration(db_configuration_file)

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

def action_sign_login_in_console
  puts "\nВыберите регистрация или авторизация\nregistr - 1\nlogin - 2\nexit - 9"
  choice = STDIN.gets.chomp
  params = set_params(choice) if choice.to_i == 1 || choice.to_i == 2
  return puts 'bye bye' unless choice.to_i != 9
  if choice.to_i == 1
    user = create_user(params)
    if user.present?
      puts "Регистрация #{user.name} завершена\n\n"
      action_with_message_in_console(user)
    end
  elsif choice.to_i == 2
    user = User.authenticate(params[:email], params[:password])
    if user.present?
      puts "Авторизация #{user.name} успешна\n\n"
      action_with_message_in_console(user)
    else
      puts 'Не верный email или password'
      return action_sign_login_in_console
    end
  else
    puts "wrong input - #{choice}"
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
    elsif choice.to_i == 2 || choice.to_i == 3
      read_message(choice, user)
    else
      puts "wrong input - #{choice}"
    end
  end
end

action_sign_login_in_console
