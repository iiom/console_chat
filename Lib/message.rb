class Message
  attr_reader :name, :text, :time

  def initialize(data)
    @name = data["Name"]
    @text = data["Text"]
    @time = data["Time"]
    @whom = data["Whom"]
  end

  def self.to_s(message)
    message.each do |i|
      puts '___________________________________________'
      puts i.text
      puts "(#{i.time}) #{i.name}"
      puts '___________________________________________'
    end
  end

end