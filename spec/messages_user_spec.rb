describe 'Класс MessagesUser' do
  before(:all) do
    @user = User.create(name: 'Doby', email: 'dd@dd.ru', password: '123')
    @message = Message.create(text: 'text', whom: 'dendy', user: @user)
    @mu = MessagesUser.create(user: @user, message: @message, whom: @message.whom)
  end

  it 'создаёт объект класса MessagesUser' do
    expect(@mu.present?).to eq true
  end

  it 'создаёт связь belongs_to :message, MessagesUser.message = true' do
    expect(@mu.message.present?).to eq true
  end

  it 'создаёт связь belongs_to :user, MessagesUser.user = true' do
    expect(@mu.user.present?).to eq true
  end
end

