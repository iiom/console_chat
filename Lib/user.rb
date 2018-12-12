class User

  attr_reader :name

  def initialize
    @name = nil
  end

  def enter_name
    @name = STDIN.gets.chomp
  end
end
