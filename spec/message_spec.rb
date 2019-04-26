describe 'Класс Message' do
  before(:all) do
    @user = User.create(name: 'Bob', email: 'bb@bb.ru', password: '123')
    @message = Message.create(text: 'text', whom: 'asd', user: @user)
  end

  it 'создаёт объект класса Message' do
    expect(@message.present?).to eq true
  end

  it 'возвращает объект класса Message' do
    expect(@message.instance_of?(Message)).to eq true
  end

  it 'валидация text.presence при Message.create' do
    Message.create!()
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Text can't be blank"
  end

  it 'валидация text.length max = 255 при Message.create' do
    Message.create!(text: 'qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq')
  rescue ActiveRecord::RecordInvalid => error
    expect(error.message).to eq "Validation failed: Text is too long (maximum is 255 characters)"
  end

  it 'создаёт связь belongs_to :user, message.user.name = true' do
    expect(@message.user.name).to eq 'bob'
  end
end

