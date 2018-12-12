require_relative 'message'
require_relative 'privatemessage'

class Interface

  def action(input, name = nil, text = nil, whom = nil)
    if input == 1
      query = Message.write_message(text, name)
    elsif input == 2
      query = Message.read_message
    elsif input == 3
      query = PrivatMessage.write_message(text, name, 'Bob')
    elsif input == 4
      query = PrivatMessage.read_message(name)
    end
  end

  def choice
    puts "Выберите действие:"
    puts "написать общее сообщение - 1\nпрочитать общее сообщение - 2"
    puts "написать личное сообщение - 3\nпрочитать личное сообщенияе - 4"
    input = STDIN.gets.to_i
  end

  def text_input
    puts "Введите текст сообщения"
    text = STDIN.gets.chomp
  end

  def to_s(db)
    db.each do |i|
      puts
      print i
    end
  end
end
