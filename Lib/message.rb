class Message
  attr_reader :name, :text, :time

  def initialize(data)
    @name = data["Name"]
    @text = data["Text"]
    @time = data["Time"]
    @whom = data["Whom"]
  end
end