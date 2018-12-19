class Message
  attr_reader :name
  def initialize(data)
    @name = data["Name"]
    @text = data["Text"]
    @time = data["Time"]
    @whom = data["Whom"]
  end

  def to_s
    puts '___________________________________________'
    puts @text
    puts "(#{@time}) #{@name}"
    puts '___________________________________________'
  end
end
m = Message.new({"rowid" => 1, "Name" => "Вася", "Text" => "раз два три", "Whom" => "общее", "Time" => "11.11.1111"})
m.to_s