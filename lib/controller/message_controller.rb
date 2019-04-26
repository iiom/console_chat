class MessagesController

  def create_message(user, text, whom = nil)
    Message.create!(user: user, text: text, whom: whom)
  rescue ActiveRecord::RecordInvalid => error
    puts error
  end

  def creat_private_message(message)
    user = User.find_by(name: message.whom)
    MessagesUser.create!(user: user, message: message, whom: message.whom)
  rescue ActiveRecord::RecordInvalid => error
    puts error
  end

  def create_common_messages(message)
    User.all.each do |user|
      begin
        MessagesUser.create!(user: user, message: message)
      rescue ActiveRecord::RecordInvalid => error
        puts error
      end
    end
  end


  def write_message(user)
    puts 'enter message'
    text = STDIN.gets.chomp
    puts 'whom(name user)? if no one is left blank'
    whom = STDIN.gets.chomp
    whom == '' ? whom = nil : whom.downcase!
    if whom.nil?
      message = create_message(user, text, whom)
      create_common_messages(message)
      puts 'сообщение отправлено' unless text.blank?
    else
      if User.find_by(name: whom).nil?
        puts "нет такого пользователя #{whom}"
      else
        message = create_message(user, text, whom)
        creat_private_message(message)
        puts "сообщение отправлено пользователю: #{whom}"
      end
    end
  end


  def read_message(choice, user)
    choice.to_i == 2 ? m = MessagesUser.where(whom: user.name, view: false)\
                     : m = MessagesUser.where(user: user, view: false, whom: nil)
    if m.empty?
      choice.to_i == 2 ? (puts 'У вас нет новых личных сообщений') : (puts 'У вас нет новых сообщений')
    else
      puts "сообшения не прочитанные пользователем:"
    end
    m.each {|i| i.message.to_s}
    m.update(view: true)
  end
end