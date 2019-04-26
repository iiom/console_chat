class Session
  attr_accessor :params

  def initialize
    @params = {}
  end

  def authenticate
    user = User.find_by(email: @params[:email])
    return nil unless user.present?
    return user if BCrypt::Password.new(user.password_hash) == @params[:password]
    nil
  end

  def create_user
    User.create!(name: @params[:name], email: @params[:email], password: @params[:password])
  rescue ActiveRecord::RecordInvalid => error
    puts error
  end

  def set_params(choice)
    if choice.to_i == 1
      puts 'Введите ваше Имя(login name)'
      @params[:name] = STDIN.gets.chomp
    end

    puts 'Введите ваш (email)'
    @params[:email] = STDIN.gets.chomp
    puts 'Введите пароль'
    @params[:password] = STDIN.gets.chomp
  end
end