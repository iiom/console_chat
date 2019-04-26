require 'active_record'
require_relative 'lib/models/user'
require_relative 'lib/models/message'
require_relative 'lib/models/messages_user'
require_relative 'lib/DBConnection'
require_relative 'lib/controller/message_controller'
require_relative 'lib/controller/session_controller'


db_configuration_file = File.join(File.expand_path('..', __FILE__), 'db', 'config.yml')
DBConnection.db_configuration(db_configuration_file, "development")

def text_in_console(user)
  return nil if user.nil?
  puts
  puts '______________________________________________'
  puts "не прочитанных личных сообщений - #{MessagesUser.where(whom: user.name, view: false).count}"
  puts '______________________________________________'
  puts
  puts '1 - написать сообщение'
  puts '2 - прочитать новые сообщения адресованные пользователю'
  puts '3 - прочитать новые сообщения никому не адресованные'
  puts '9 - выход'
  puts
end

def action_sign_login_in_console
  session = Session.new
  puts "\nВыберите регистрация или авторизация\nregistr - 1\nlogin - 2\nexit - 9"
  choice = STDIN.gets.chomp
  session.set_params(choice) if choice.to_i == 1 || choice.to_i == 2
  return puts 'bye bye' unless choice.to_i != 9
  user = session.create_user if choice.to_i == 1
  user = session.authenticate if choice.to_i == 2

  if user.present?
    puts "Регистрация #{user.name} завершена\n\n" if choice.to_i == 1
    puts "Авторизация #{user.name} успешна\n\n" if choice.to_i == 2
    (return action_with_message_in_console(user))
  else
    puts 'Не верный email или password' if choice.to_i == 2
    puts "wrong input - #{choice}" if choice.to_i != 1 || choice.to_i != 2
    (return action_sign_login_in_console)
  end
end

def action_with_message_in_console(user)
  mc = MessagesController.new
  choice = nil
  while choice.to_i != 9
    text_in_console(user)
    choice = STDIN.gets.chomp
    if choice.to_i == 9
      return puts 'bye bye'
    elsif choice.to_i == 1
      mc.write_message(user)
    elsif choice.to_i == 2 || choice.to_i == 3
      mc.read_message(choice, user)
    else
      puts "wrong input - #{choice}"
    end
  end
end

action_sign_login_in_console


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# u1 = User.create(name: 'Kolyan', email: 'ff@ff.ru', password: '123')
# u2 = User.create(name: 'Antoxa', email: 'ss@ss.ru', password: '123')
# u3 = User.create(name: 'Valera', email: 'vv@vv.ru', password: '123')
#
# u = User.all[2]

# MessagesController.new.write_message(u)


# choice = 3
# read_message(choice, u)


# p MessagesUser.where(user_id: u.id, view: false, message.whom: nil)
