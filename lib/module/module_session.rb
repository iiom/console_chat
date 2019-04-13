module Session

  def set_params(choice)
    params = Hash.new

    if choice.to_i == 1
      puts 'Введите ваше Имя(login name)'
      params[:name] = STDIN.gets.chomp
    end

    puts 'Введите ваш (email)'
    params[:email] = STDIN.gets.chomp
    puts 'Введите пароль'
    params[:password] = STDIN.gets.chomp
    params
  end

  def create_user(params)
    User.create!(name: params[:name], email: params[:email], password: params[:password])
  rescue ActiveRecord::RecordInvalid => error
    puts error
    return action_sign_login_in_console
  end
end