require 'rspec'
require 'active_record'
require 'sqlite3'
require_relative '../lib/models/user'

describe 'Класс работы с User' do
  before(:all) do
    yml = File.join(File.expand_path(Dir.pwd),  'db', 'config.yml')
    p yml
    ActiveRecord::Base.establish_connection(YAML.load(File.read(yml))["test"])
    ActiveRecord::Migration.maintain_test_schema!
    @user = User.create(name: 'Jack', email: 'qq@qq.ru', password: '123')
  end

  it 'создание нового пользователя' do
    expect(@user.nil?).to eq false
  end

  it 'читает имя пользователя' do
    expect(@user.name).to eq 'Jack'
  end

  it 'возвращает объект класса' do
    expect(@user.instance_of?(User)).to eq true
  end
end