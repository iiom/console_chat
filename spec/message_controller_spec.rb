describe 'Класс MessagesController' do
  before(:all) do
    @mc = MessagesController.new
    @user1 = User.create(name: 'filo', email: 'fl@asd.ru', password: '12')
    @user2 = User.create(name: 'rango', email: 'rango@asd.ru', password: '12')
  end

  it 'создание бъекта класса Message' do
    @mc.create_message(@user1, text = 'qqqqq', whom = 'rango')
    expect(@mc.present?).to eq true
  end

  it 'creat_private_message' do
    expect(@mc.creat_private_message(Message.last).present?).to eq true
  end

  it 'create_common_messages' do
    message = Message.create(user: @user2, text: 'all')
    @mc.create_common_messages(message)
    expect(MessagesUser.where(whom: nil, message_id: message.id).count).to eq User.all.count
  end
end