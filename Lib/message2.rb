class Message2
  attr_reader :name, :text, :time

  def initialize(mes)
    @name = mes["Name"]
    @text = mes["Text"]
    @time = mes["Time"]
    @whom = mes["Whom"]
  end

  # def to_s
  #   "#{@name} - #{@text} : (#{@time}) #{@whom}"
  # end
end