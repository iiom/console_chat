describe 'Класс User' do
  before(:all) do
    @user = User.create(name: 'Jack', email: 'qq@qq.ru', password: '123')
  end

  it 'создание бъект класса User' do
    expect(@user.present?).to eq true
  end

  it 'возвращает объект класса User' do
    expect(@user.instance_of?(User)).to eq true
  end

  it 'приводит буквы к нижнему регистру' do
    expect(@user.name).to eq 'jack'
  end

  it 'валидация name.presence при User.create' do
    User.create!(email: 'qqq@qq.ru', password: '123')
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Name can't be blank,\
 Name only allows letters numbers & _"
  end

  it 'валидация name.format при User.create' do
    User.create!(name: '!!dsds',email: 'qqq@qq.ru', password: '123')
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Name only allows letters numbers & _"
  end

  it 'валидация name.uniq? при User.create' do
    User.create!(name: 'jack', email: 'qq1212@qq.ru', password: '123')
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Name has already been taken"
  end

  it 'валидация email.presence при User.create' do
    User.create!(name: 'Jack', password: '123')
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Email can't be blank, Email email format only"
  end

  it 'валидация email.format при User.create' do
    User.create!(name: 'asdasd',email: 'qqqqq.ru', password: '123')
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Email email format only"
  end

  it 'валидация email.uniq? при User.create' do
    User.create!(name: 'Jack', email: 'qq@qq.ru', password: '123')
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Email has already been taken"
  end

  it 'валидация password.presence при User.create' do
    User.create!(name: 'Jack', email: 'qqqq@qq.ru')
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Password can't be blank"
  end
end