module Messages

  def create_message(user, text, whom)
    Message.create!(text: text, user: user, whom: whom)
  rescue ActiveRecord::RecordInvalid => error
    puts error
  end

  def write_message(user)
    puts 'enter message'
    text = STDIN.gets.chomp
    puts 'whom(name user)? if no one is left blank'
    whom = STDIN.gets.chomp
    whom = nil if whom == ''
    if whom.nil?
      create_message(user, text, whom)
      puts 'сообщение отправлено' unless text.blank?
    else
      if User.find_by(name: whom).nil?
        puts "нет такого пользователя #{whom}"
      else
        create_message(user, text, whom)
        puts "сообщение отправлено пользователю: #{whom}"
      end
    end
  end

  def read_message(choice, user)
    choice.to_i == 2 ? m = Message.where(whom: user.name, view: false) : m = Message.where(user_id: user.id)
    if m.empty?
      choice.to_i == 2 ? (puts 'У вас нет новых сообщений') : (puts 'У вас нет новых сообщений')
    else
      puts "сообшения не прочитанные пользователем:"
    end
    m.each do |i|
      puts
      print "from: #{i.user.name}"
      i.whom.nil? ? puts : (puts " to: #{i.whom}")
      puts "text: #{i.text}"
      puts i.created_at
      m.update(view: true) if choice.to_i == 2
    end
  end
end