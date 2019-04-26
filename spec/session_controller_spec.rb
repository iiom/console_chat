describe 'Класс Session' do
  before(:all) do
    @session = Session.new
    @session.params = {name: 'Saske', email: 'konoha@kitai.cn', password: '123'}
  end

  it 'создание бъект класса User' do
    expect(@session.create_user.present?).to eq true
  end

  it 'авторизация true' do
    expect(@session.authenticate.name).to eq 'saske'
  end
end