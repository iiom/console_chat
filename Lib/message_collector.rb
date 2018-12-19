require_relative 'message'

class MessageCollector
  def self.load_message(db_answer)
    messages = []
    db_answer.each do |str|
      messages << Message.new(str)
    end
    messages
  end
end

